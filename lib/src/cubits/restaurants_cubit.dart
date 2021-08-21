import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/models/place.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/states/restaurants_state.dart';
import 'package:expat_assistant/src/utils/places_utils.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantRepository _restaurantRepository;
  RestaurantsCubit(this._restaurantRepository)
      : super(const RestaurantsState(status: RestaurantsStatus.init));

  Future<void> loadDataToScreen() async {
    String error;
    String locationText;
    String addressText;
    emit(state.copyWith(status: RestaurantsStatus.loading));
    var permissionStatus = await Permission.location.status;
    if (permissionStatus.isDenied) {
      permissionStatus = await Permission.location.request();
      if (!permissionStatus.isGranted) {
        return;
      }
    }
    try {
      var currentLocation = await PlacesUtils.getLocation();
      if (currentLocation.runtimeType == String) {
        error = currentLocation;
        emit(state.copyWith(
            status: RestaurantsStatus.loadError, errorMessage: error));
      } else {
        var myLocation = currentLocation;
        locationText = myLocation.latitude.toString() +
            "," +
            myLocation.longitude.toString();
        LocationList locationList = await _restaurantRepository
            .getNearbyRestaurant(location: locationText);
        if (locationList == null) {
          emit(state.copyWith(
              status: RestaurantsStatus.loadError,
              errorMessage: 'An error occurs while loading restaurants!'));
        } else {
          addressText = await PlacesUtils.getAddress(myLocation);
          if (addressText == null) {
            addressText = "Cannot recognize your address";
          }
          emit(state.copyWith(
              status: RestaurantsStatus.loaded,
              currentAddress: addressText,
              locations: locationList,
              currentLat: myLocation.latitude,
              currentLng: myLocation.longitude));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RestaurantsStatus.loadError, errorMessage: e.toString()));
    }
  }

  Future<void> getNextRestaurants(LocationList oldData) async {
    if (!state.status.isLoadingMoreRestaurants) {
      emit(state.copyWith(status: RestaurantsStatus.loadingMoreRestaurants));
      try {
        LocationList nextData = await _restaurantRepository.getNextRestaurant(
            nextPageToken: oldData.nextPageToken);
        if (nextData == null) {
          emit(state.copyWith(
              status: RestaurantsStatus.loadMoreRestaurantError,
              nextLocations: oldData,
              errorMessage: "An error occurs while loading data"));
        } else {
          oldData.htmlAttributions = nextData.htmlAttributions;
          oldData.nextPageToken = nextData.nextPageToken;
          oldData.results.addAll(nextData.results);
          emit(state.copyWith(
              status: RestaurantsStatus.loadedMoreRestaurants,
              nextLocations: oldData));
        }
      } on Exception catch (e) {
        emit(state.copyWith(
            status: RestaurantsStatus.loadMoreRestaurantError,
            nextLocations: oldData,
            errorMessage: e.toString()));
      }
    }
  }

  Future<void> uploadImage(File image) async {
    emit(state.copyWith(status: RestaurantsStatus.uploadingImage));
    try {
      String fileName = basename(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('food_image/$fileName');
      UploadTask uploadTask = reference.putFile(image);
      uploadTask.then((result) {
        result.ref.getDownloadURL().then((value) {
          print(value);
          emit(state.copyWith(
              status: RestaurantsStatus.uploadedImage, imageUrl: value));
        });
      });
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RestaurantsStatus.uploadImageError,
          errorMessage: e.toString()));
    }
  }

  Future<void> detectFood(String imageUrl) async {
    emit(state.copyWith(status: RestaurantsStatus.recognizingFood));
    try {
      String foodName =
          await _restaurantRepository.detectFood(imageUrl: imageUrl);
      if (foodName == null) {
        emit(state.copyWith(
            status: RestaurantsStatus.recognizeFoodError,
            errorMessage: 'An error occur while recognizing food'));
      }else if(foodName == 'Cannot detect food!'){
        emit(state.copyWith(
            status: RestaurantsStatus.recognizeFoodError,
            errorMessage: 'Cannot detect food in the image'));
      } else {
        String result = TextUtils.getFoodName(foodName);
        emit(state.copyWith(
            status: RestaurantsStatus.recognizeFoodSuccess, foodName: result));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RestaurantsStatus.recognizeFoodError,
          errorMessage: e.toString()));
    }
  }
}
