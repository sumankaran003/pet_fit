import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/add_pet_module/add_pet.dart';
import 'package:pet_fit/addPet/capture_image_module/capture_image_module_bloc.dart';
import 'package:pet_fit/utilMethods.dart';

class ImageCapturePage extends StatefulWidget {
  @override
  State<ImageCapturePage> createState() => _ImageCapturePageState();
}

class _ImageCapturePageState extends State<ImageCapturePage> {
  @override
  Widget build(BuildContext context) {
    final imageUploadBloc = BlocProvider.of<ImageCaptureBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker & Uploader'),
      ),
      body: BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
        listener: (context, state) {
          if (state is CaptureImageUploadFailure) {
            showSnackBar(
                "Image upload failed", "Something went wrong", "failure");
          }
          if (state is CameraNotAvailableState) {
            showSnackBar("Camera failed", "Something went wrong", "failure");
          }
        },
        builder: (context, state) {
          if (state is ImagesCapturedState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.pickedImages.length,
                    itemBuilder: (context, index) {
                      return Image.file(state.pickedImages[index]);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    imageUploadBloc
                        .add(UploadCaptureImagesEvent(state.pickedImages));
                  },
                  child: const Text('Upload Images'),
                ),
              ],
            );
          } else if (state is CaptureImageUploadProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CapturedImagesUploadedState) {
            return Column(
              children: [
                const Text('Images Successfully Uploaded'),
                Expanded(
                  child: ListView(
                    children: state.imageUrls
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
                  imageUploadBloc.add(CaptureImagesEvent());
                },
                child: const Text('Capture Images'),
              ),
            );
          }
        },
      ),
    );
  }
}
