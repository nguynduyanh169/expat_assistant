import 'package:equatable/equatable.dart';

class CameraState extends Equatable {
  final CameraStatus status;
  final String message;
  final String imageUrl;
  final String foodName;

  const CameraState({this.status, this.message, this.imageUrl, this.foodName});

  @override
  // TODO: implement props
  List<Object> get props => [status, message, imageUrl, foodName];

  CameraState copyWith(
      {CameraStatus status, String message, String imageUrl, String foodName}) {
    return CameraState(
        status: status ?? this.status,
        message: message ?? this.message,
        imageUrl: imageUrl ?? this.imageUrl,
        foodName: foodName ?? this.foodName);
  }
}

enum CameraStatus {
  uploadingImage,
  uploadedImage,
  uploadImageError,
  init,
  recognizingFood,
  recognizeFoodSuccess,
  recognizeFoodError,
}

extension Explaination on CameraStatus {
  bool get isUploadingImage => this == CameraStatus.uploadingImage;
  bool get isUploadedImage => this == CameraStatus.uploadedImage;
  bool get isUploadImageError => this == CameraStatus.uploadImageError;
  bool get isInit => this == CameraStatus.init;
  bool get isRecognizing => this == CameraStatus.recognizingFood;

  bool get isRecognizeSuccess => this == CameraStatus.recognizeFoodSuccess;

  bool get isRecognizeFoodError => this == CameraStatus.recognizeFoodError;
}
