import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/addPet/select_video_module/select_video_module_bloc.dart';
import 'package:pet_fit/utilMethods.dart';

class VideoPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoPickerBloc = BlocProvider.of<VideoPickerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Uploader'),
      ),
      body: BlocConsumer<VideoPickerBloc, VideoPickerState>(
        listener: (context, state) {
          if(state is VideoUploadFailure){
            showSnackBar("Video upload failed", "Something went wrong", "failure");
          }
        },
        builder: (context, state) {
          if (state is VideosPickedState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Image.network(

                        "https://cdn-icons-png.flaticon.com/512/4503/4503915.png",
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    videoPickerBloc.add(UploadVideosEvent([state.pickedVideos]));
                  },
                  child: const Text('Upload Video'),
                ),
              ],
            );
          }
          else if(state is VideoUploadProgress){
            return const Center(child: CircularProgressIndicator());
          }

          else if (state is VideosUploadedState) {
            return Column(
              children: [
                const Text('Video Successfully Uploaded'),
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
                  videoPickerBloc.add(PickVideosEvent());
                },
                child: const Text('Pick Video'),
              ),
            );
          }
        },
      ),
    );
  }
}
