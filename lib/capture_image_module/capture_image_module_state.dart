part of 'capture_image_module_bloc.dart';


abstract class ImageCaptureState {}

class ImageCaptureInitial extends ImageCaptureState {}

class ImageCaptureFailure extends ImageCaptureState {}

class CaptureImageUploadProgress extends ImageCaptureState {}

class CaptureImageUploadFailure extends ImageCaptureState {}

class CameraNotAvailableState extends ImageCaptureState {}


class ImagesCapturedState extends ImageCaptureState {
  final List<File> pickedImages;

  ImagesCapturedState(this.pickedImages);
}

class CapturedImagesUploadedState extends ImageCaptureState {
  final List<String> imageUrls;

  CapturedImagesUploadedState(this.imageUrls);
}

