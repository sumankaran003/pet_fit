import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/capture_image_module/capture_image.dart';
import 'package:pet_fit/addPet/capture_image_module/capture_image_module_bloc.dart';
import 'package:pet_fit/widgets.dart';


// runApp(const MyApp());

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
   // required this.camera,
  });


  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<CameraDescription> initializeCamera() async {
    final cameras = await availableCameras();
//
// // Get a specific camera from the list of available cameras.
    return cameras.first;
  }

  Future<void> initializeControllerAsync() async {
    try {
      // Get the CameraDescription by awaiting the initializeCamera() function.
      final cameraDescription = await initializeCamera();

      // Create the CameraController with the obtained CameraDescription.
      _controller = CameraController(
        cameraDescription,
        ResolutionPreset.low,
      );

      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();

      // Make sure to call setState() after updating the controller state.
      setState(() {});
    } catch (e) {
      // Handle any errors that might occur during initialization.
      print('Error initializing camera: $e');
    }
  }
    @override
    initState() {
      super.initState();

      initializeControllerAsync();

      // Next, initialize the controller. This returns a Future.
      //_initializeControllerFuture = _controller.initialize();
    }

    @override
    void dispose() {
      // Dispose of the controller when the widget is disposed.
      _controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Take a picture')),
        // You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();

              if (!mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image.path,
                      ),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      );
    }

}
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final imageUploadBloc = BlocProvider.of<ImageCaptureBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath)),
          BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              return GestureDetector(
                  onTap: () {

                    imageUploadBloc.add(UploadCaptureImagesEvent([File(imagePath)]));
                    Get.off(()=>ImageCapturePage());

                  }, child: proceedButton("Proceed"));
            },
          )
        ],
      ),
    );
  }
}
