import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/capture_video_module/capture_video.dart';
import 'package:pet_fit/addPet/capture_video_module/capture_video_module_bloc.dart';
import 'package:pet_fit/widgets.dart';
import 'package:video_player/video_player.dart';

class TakeVideoScreen extends StatefulWidget {
  const TakeVideoScreen({Key? key}) : super(key: key);

  @override
  _TakeVideoScreenState createState() => _TakeVideoScreenState();
}

class _TakeVideoScreenState extends State<TakeVideoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<CameraDescription> initializeCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  Future<void> initializeControllerAsync() async {
    try {
      final cameraDescription = await initializeCamera();
      _controller = CameraController(
        cameraDescription,
        ResolutionPreset.low,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      _initializeControllerFuture = _controller.initialize();
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    initializeControllerAsync();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record a Video')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            await _controller.startVideoRecording();
            await Future.delayed(
                const Duration(seconds: 5)); //limiting to 5 sec
            final video = await _controller.stopVideoRecording();
            Get.to(() => DisplayVideoScreen(videoPath: video.path));
          } catch (e) {}
        },
        child: const Icon(Icons.videocam),
      ),
    );
  }
}

class DisplayVideoScreen extends StatelessWidget {
  final String videoPath;

  DisplayVideoScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController _videoPlayerController =
        VideoPlayerController.file(File(videoPath));
    final videoUploadBloc = BlocProvider.of<VideoCaptureBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Video Preview')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4, // Adjust the aspect ratio as needed
              child: VideoPlayer(_videoPlayerController),
            ),
            ElevatedButton(
              onPressed: () {
                _videoPlayerController.initialize().then((_) {
                  // Ensure the first frame is shown, and then play the video.
                  _videoPlayerController.play();
                });
              },
              child: const Text('Play'),
            ),
            BlocConsumer<VideoCaptureBloc, VideoCaptureState>(
              listener: (context, state) {},
              builder: (context, state) {
                return GestureDetector(
                    onTap: () {
                      videoUploadBloc
                          .add(UploadCaptureVideosEvent([File(videoPath)]));
                      Get.off(() => VideoCapturePage());
                    },
                    child: proceedButton("Proceed"));
              },
            )
          ],
        ),
      ),
    );
  }
}
