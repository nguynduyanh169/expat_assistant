import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:expat_assistant/src/repositories/restaurant_repository.dart';
import 'package:expat_assistant/src/utils/text_utils.dart';
import 'package:path/path.dart';
import 'package:expat_assistant/src/states/camera_state.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraCubit extends Cubit<CameraState> {
  RestaurantRepository _restaurantRepository;
  CameraCubit(this._restaurantRepository)
      : super(const CameraState(status: CameraStatus.init));

  Future<void> uploadImage(File image) async {
    emit(state.copyWith(status: CameraStatus.uploadingImage));
    try {
      String fileName = basename(image.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('food_image/$fileName');
      UploadTask uploadTask = reference.putFile(image);
      uploadTask.then((result) {
        result.ref.getDownloadURL().then((value) {
          print(value);
          emit(state.copyWith(
              status: CameraStatus.uploadedImage, imageUrl: value));
        });
      });
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CameraStatus.uploadImageError, message: e.toString()));
    }
  }

  Future<void> detectFood(String imageUrl) async {
    emit(state.copyWith(status: CameraStatus.recognizingFood));
    try {
      String foodName =
          await _restaurantRepository.detectFood(imageUrl: imageUrl);
      print(foodName);
      if (foodName == null) {
        emit(state.copyWith(
            status: CameraStatus.recognizeFoodError,
            message: 'An error occur while recognizing food'));
      } else if (foodName == 'Cannot detect food!') {
        emit(state.copyWith(
            status: CameraStatus.recognizeFoodError,
            message: 'Cannot detect food in the image'));
      } else {
        String result = TextUtils.getFoodName(foodName);
        emit(state.copyWith(
            status: CameraStatus.recognizeFoodSuccess, foodName: result));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: CameraStatus.recognizeFoodError, message: e.toString()));
    }
  }
}
