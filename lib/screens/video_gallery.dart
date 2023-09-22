import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_fit/screens/video_player.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> videos;

  const PhotoGallery({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: videos.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => VideoApp(videoUrl: videos[index]));
              },
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/4503/4503915.png",
                fit: BoxFit.cover,
              ),
            );

          },
        ),
      ),
    );
  }
}
