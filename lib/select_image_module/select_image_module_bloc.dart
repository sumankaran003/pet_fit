import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
part 'select_image_module_event.dart';
part 'select_image_module_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<PickImagesEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      final pickedImages = await imagePicker.pickMultiImage();
      emit(ImagesPickedState(pickedImages.map((e) => File(e.path)).toList()));
    });

    on<UploadImagesEvent>((event, emit) async {
      emit(ImageUploadProgress());

      try {
        final List<String> imageUrls = [];
        for (final imageFile in event.imageFiles) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('images/${DateTime.now().millisecondsSinceEpoch}');
          final uploadTask = ref.putFile(imageFile);
          final snapshot = await uploadTask.whenComplete(() {});
          final imageUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
        emit(ImagesUploadedState(imageUrls));
      } catch (e) {
        emit(ImageUploadFailure());
        //print('Error uploading images: $e');
      }
    });
  }
}
