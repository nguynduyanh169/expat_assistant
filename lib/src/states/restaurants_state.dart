import 'package:equatable/equatable.dart';
import 'package:expat_assistant/src/models/place.dart';

class RestaurantsState extends Equatable {
  final String currentAddress;
  final String errorMessage;
  final RestaurantsStatus status;
  final String foodName;
  final String imageUrl;
  final LocationList locations;
  final LocationList nextLocations;

  const RestaurantsState(
      {this.currentAddress,
      this.errorMessage,
      this.status,
      this.foodName,
      this.imageUrl,
      this.locations,
      this.nextLocations});

  @override
  // TODO: implement props
  List<Object> get props => [
        currentAddress,
        errorMessage,
        status,
        foodName,
        imageUrl,
        locations,
        nextLocations
      ];

  RestaurantsState copyWith(
      {String currentAddress,
      String errorMessage,
      RestaurantsStatus status,
      String foodName,
      String imageUrl,
      LocationList locations,
      LocationList nextLocations}) {
    return RestaurantsState(
        currentAddress: currentAddress ?? this.currentAddress,
        errorMessage: errorMessage ?? this.currentAddress,
        status: status ?? this.status,
        foodName: foodName ?? this.foodName,
        imageUrl: imageUrl ?? this.imageUrl,
        locations: locations ?? this.locations,
        nextLocations: nextLocations ?? this.nextLocations);
  }
}

enum RestaurantsStatus {
  init,
  loading,
  loaded,
  loadError,
  recognizingFood,
  recognizeFoodSuccess,
  recognizeFoodError,
  uploadingImage,
  uploadedImage,
  uploadImageError,
  loadingMoreRestaurants,
  loadedMoreRestaurants,
  loadMoreRestaurantError
}

extension Explaination on RestaurantsStatus {
  bool get isInit => this == RestaurantsStatus.init;

  bool get isLoading => this == RestaurantsStatus.loading;

  bool get isLoaded => this == RestaurantsStatus.loaded;

  bool get isLoadError => this == RestaurantsStatus.loadError;

  bool get isRecognizing => this == RestaurantsStatus.recognizingFood;

  bool get isRecognizeSuccess => this == RestaurantsStatus.recognizeFoodSuccess;

  bool get isRecognizeFoodError => this == RestaurantsStatus.recognizeFoodError;

  bool get isUploadingImage => this == RestaurantsStatus.uploadingImage;

  bool get isUploadedImage => this == RestaurantsStatus.uploadedImage;

  bool get isUploadImageError => this == RestaurantsStatus.uploadImageError;

  bool get isLoadingMoreRestaurants =>
      this == RestaurantsStatus.loadingMoreRestaurants;

  bool get isLoadedMoreRestaurants =>
      this == RestaurantsStatus.loadedMoreRestaurants;

  bool get isLoadMoreRestaurantError => this == RestaurantsStatus.loadMoreRestaurantError;
}
