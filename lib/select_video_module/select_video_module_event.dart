part of 'select_video_module_bloc.dart';


abstract class VideoPickerEvent {}

class PickVideosEvent extends VideoPickerEvent {}

class UploadVideosEvent extends VideoPickerEvent {
  final List<File> videoFiles;

  UploadVideosEvent(this.videoFiles);
}

