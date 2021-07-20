import 'package:equatable/equatable.dart';

class CameraState extends Equatable {
  final CameraStatus status;
  final String message;
  final String imageUrl;

  const CameraState({this.status, this.message, this.imageUrl});

  @override
  // TODO: implement props
  List<Object> get props => [status, message, imageUrl];

  CameraState copyWith({CameraStatus status, String message, String imageUrl}) {
    return CameraState(
        status: status ?? this.status,
        message: message ?? this.message,
        imageUrl: imageUrl ?? this.imageUrl);
  }
}

enum CameraStatus { uploadingImage, uploadedImage, uploadImageError, init }

extension Explaination on CameraStatus {
  bool get isUploadingImage => this == CameraStatus.uploadingImage;
  bool get isUploadedImage => this == CameraStatus.uploadedImage;
  bool get isUploadImageError => this == CameraStatus.uploadImageError;
  bool get isInit => this == CameraStatus.init;
}
