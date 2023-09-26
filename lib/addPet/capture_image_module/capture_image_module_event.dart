part of 'capture_image_module_bloc.dart';

abstract class ImageCaptureEvent {}

class CaptureImagesEvent extends ImageCaptureEvent {}

class UploadCaptureImagesEvent extends ImageCaptureEvent {
  final List<File> imageFiles;

  UploadCaptureImagesEvent(this.imageFiles);
}
