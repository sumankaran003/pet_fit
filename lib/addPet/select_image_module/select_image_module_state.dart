part of 'select_image_module_bloc.dart';

abstract class ImagePickerState {}

class ImagePickerInitial extends ImagePickerState {}

class ImageUploadProgress extends ImagePickerState {}

class ImageUploadFailure extends ImagePickerState {}

class ImagesPickedState extends ImagePickerState {
  final List<File> pickedImages;

  ImagesPickedState(this.pickedImages);
}

class ImagesUploadedState extends ImagePickerState {
  final List<String> imageUrls;

  ImagesUploadedState(this.imageUrls);
}
