import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/addPet/select_image_module/select_image_module_bloc.dart';
import 'package:pet_fit/utilMethods.dart';

class ImagePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker & Uploader'),
      ),
      body: BlocConsumer<ImagePickerBloc, ImagePickerState>(
        listener: (context, state) {
          if(state is ImageUploadFailure){
             showSnackBar("Image upload failed", "Something went wrong", "failure");
          }
        },
        builder: (context, state) {
          if (state is ImagesPickedState) {
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
                    imagePickerBloc.add(UploadImagesEvent(state.pickedImages));
                  },
                  child: const Text('Upload Images'),
                ),
              ],
            );
          }
          else if(state is ImageUploadProgress){
            return const Center(child: CircularProgressIndicator());
          }

          else if (state is ImagesUploadedState) {
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
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  imagePickerBloc.add(PickImagesEvent());
                },
                child: const Text('Pick Images'),
              ),
            );
          }
        },
      ),
    );
  }
}
