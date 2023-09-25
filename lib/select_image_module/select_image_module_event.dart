part of 'select_image_module_bloc.dart';

abstract class ImagePickerEvent {}

class PickImagesEvent extends ImagePickerEvent {}

class UploadImagesEvent extends ImagePickerEvent {
  final List<File> imageFiles;

  UploadImagesEvent(this.imageFiles);
}
