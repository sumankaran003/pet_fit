import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'capture_video_module_event.dart';
part 'capture_video_module_state.dart';

class VideoCaptureBloc
    extends Bloc<VideoCaptureEvent, VideoCaptureState> {
  VideoCaptureBloc() : super(VideoCaptureInitial()) {
    on<UploadCaptureVideosEvent>((event, emit) async {
      emit(CaptureVideoUploadProgress());

      try {
        final List<String> imageUrls = [];
        for (final imageFile in event.videoFiles) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('videos/${DateTime.now().millisecondsSinceEpoch}');
          final uploadTask = ref.putFile(imageFile);
          final snapshot = await uploadTask.whenComplete(() {});
          final imageUrl = await snapshot.ref.getDownloadURL();
          imageUrls.add(imageUrl);
        }
        emit(CapturedVideosUploadedState(imageUrls));
      } catch (e) {
        emit(CaptureVideoUploadFailure());
      }
    });
  }
}
