part of 'capture_video_module_bloc.dart';

abstract class VideoCaptureState {}

class VideoCaptureInitial extends VideoCaptureState {}

class VideoCaptureFailure extends VideoCaptureState {}

class CaptureVideoUploadProgress extends VideoCaptureState {}

class CaptureVideoUploadFailure extends VideoCaptureState {}

class CameraNotAvailableState extends VideoCaptureState {}

class VideosCapturedState extends VideoCaptureState {
  final List<File> pickedVideos;

  VideosCapturedState(this.pickedVideos);
}

class CapturedVideosUploadedState extends VideoCaptureState {
  final List<String> videoUrls;

  CapturedVideosUploadedState(this.videoUrls);
}
