import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/add_pet_module/add_pet.dart';
import 'package:pet_fit/capture_video_module/capture_video_module_bloc.dart';
import 'package:pet_fit/utilMethods.dart';

class VideoCapturePage extends StatefulWidget {
  @override
  State<VideoCapturePage> createState() => _VideoCapturePageState();
}

class _VideoCapturePageState extends State<VideoCapturePage> {
  @override
  Widget build(BuildContext context) {
    final videoUploadBloc = BlocProvider.of<VideoCaptureBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Picker & Uploader'),
      ),
      body: BlocConsumer<VideoCaptureBloc, VideoCaptureState>(
        listener: (context, state) {
          if (state is CaptureVideoUploadFailure) {
            showSnackBar(
                "Video upload failed", "Something went wrong", "failure");
          }
          if (state is CameraNotAvailableState) {
            showSnackBar("Camera failed", "Something went wrong", "failure");
          }
        },
        builder: (context, state) {
          if (state is VideosCapturedState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.pickedVideos.length,
                    itemBuilder: (context, index) {
                     // return Image.file(state.pickedVideos[index]);
                      return Container();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    videoUploadBloc
                        .add(UploadCaptureVideosEvent(state.pickedVideos));
                  },
                  child: const Text('Upload Videos'),
                ),
              ],
            );
          } else if (state is CaptureVideoUploadProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CapturedVideosUploadedState) {
            return Column(
              children: [
                const Text('Videos Successfully Uploaded'),
                Expanded(
                  child: ListView(
                    children: state.videoUrls
                        .map((url) => Text(
                      url, // Adjust the length as needed
                      overflow: TextOverflow.ellipsis,
                    ))
                        .toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.off(()=>AddPetScreen());

                  },
                  child: const Text('Done'),
                ),
              ],
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  videoUploadBloc.add(CaptureVideosEvent());
                },
                child: const Text('Capture Videos'),
              ),
            );
          }
        },
      ),
    );
  }
}
