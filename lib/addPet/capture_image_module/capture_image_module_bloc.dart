import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'capture_image_module_event.dart';
part 'capture_image_module_state.dart';

class ImageCaptureBloc extends Bloc<ImageCaptureEvent, ImageCaptureState> {
  late CameraController _cameraController;

  ImageCaptureBloc() : super(ImageCaptureInitial()) {
    on<CaptureImagesEvent>((event, emit) async {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(CameraNotAvailableState());
        return;
      }
      final firstCamera = cameras.first;
      late CameraController _controller;
      //late Future<void> _initializeControllerFuture;
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        firstCamera,
        // Define the resolution to use.
        ResolutionPreset.low,
      );
     // _initializeControllerFuture = _controller.initialize();
      try {
        final XFile? photo =
            await _cameraController.takePicture(); // Capture the photo

        if (photo != null) {
          emit(ImagesCapturedState([File(photo.path)]));
        }
      } catch (e) {
        emit(ImageCaptureFailure());
      }

    });

    on<UploadCaptureImagesEvent>((event, emit) async {
      emit(CaptureImageUploadProgress());

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
        emit(CapturedImagesUploadedState(imageUrls));
      } catch (e) {
        emit(CaptureImageUploadFailure());
      }
    });
  }

  // void _initializeCamera() async {
  //   final cameras = await availableCameras(); // Get available cameras
  //   if (cameras.isEmpty) {
  //     emit(CameraNotAvailableState());
  //     return;
  //   }
  //
  //   final camera = cameras[0]; // Use the first available camera
  //   _cameraController = CameraController(
  //     camera,
  //     ResolutionPreset.high,
  //   );
  //
  //   await _cameraController.initialize(); // Initialize the camera
  // }

  @override
  Future<void> close() {
    _cameraController.dispose();
    return super.close();
  }
}
