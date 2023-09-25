part of 'select_video_module_bloc.dart';



abstract class VideoPickerState {}

class VideoPickerInitial extends VideoPickerState {}

class VideoUploadProgress extends VideoPickerState {}

class VideoUploadFailure extends VideoPickerState {}

class VideosPickedState extends VideoPickerState {
  final File pickedVideos;

  VideosPickedState(this.pickedVideos);
}

class VideosUploadedState extends VideoPickerState {
  final List<String> videoUrls;

  VideosUploadedState(this.videoUrls);
}

