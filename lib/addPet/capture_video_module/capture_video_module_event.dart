part of 'capture_video_module_bloc.dart';

abstract class VideoCaptureEvent {}

class CaptureVideosEvent extends VideoCaptureEvent {}

class UploadCaptureVideosEvent extends VideoCaptureEvent {
  final List<File> videoFiles;

  UploadCaptureVideosEvent(this.videoFiles);
}
