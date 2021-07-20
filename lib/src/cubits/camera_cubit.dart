import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:expat_assistant/src/states/camera_state.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState(status: CameraStatus.init));

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
}
