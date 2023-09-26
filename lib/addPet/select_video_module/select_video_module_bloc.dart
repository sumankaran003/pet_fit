import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'select_video_module_event.dart';
part 'select_video_module_state.dart';


class VideoPickerBloc extends Bloc<VideoPickerEvent, VideoPickerState> {
  VideoPickerBloc() : super(VideoPickerInitial()) {
    on<VideoPickerEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      final pickedVideo = await imagePicker.pickVideo(
        source: ImageSource.gallery,
      );
      if (pickedVideo != null) {
        final File videoFile = File(pickedVideo.path);
        emit(VideosPickedState(videoFile));
      }
    });

    on<UploadVideosEvent>((event, emit) async {

      emit(VideoUploadProgress());

      try {
        final List<String> videoUrls = [];
        for (final videoFile in event.videoFiles) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('videos/${DateTime.now().millisecondsSinceEpoch}');
          final uploadTask = ref.putFile(videoFile);
          final snapshot = await uploadTask.whenComplete(() {});
          final videoUrl = await snapshot.ref.getDownloadURL();
          videoUrls.add(videoUrl);
        }
        emit(VideosUploadedState(videoUrls));

      } catch (e) {
        emit(VideoUploadFailure());
        //print('Error uploading images: $e');
      }
    });
  }
}