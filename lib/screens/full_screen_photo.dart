import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenPhoto extends StatelessWidget {

  final String imageLink;

  const FullScreenPhoto({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Full Screen Image View'),
      ),

      body: Center(
        child: Hero(
          tag: imageLink,
          child: PhotoView(
            backgroundDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
            ),
            imageProvider: NetworkImage(imageLink),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.0,
          ),
        ),
      ),
    );
  }
}
