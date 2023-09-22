import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_fit/models/pet_model.dart';
import 'package:pet_fit/screens/photo_gallery.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetModel pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(pet.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              pet.images[0],
              height: Get.width * 0.75,
              width: Get.width * 0.85,
              fit: BoxFit.cover,
            ),
            DetailsText(
              field: "Name",
              value: pet.name,
            ),
            DetailsText(
              field: "Breed",
              value: pet.breed,
            ),
            DetailsText(
              field: "Location",
              value: pet.location,
            ),
            DetailsText(
              field: "Age",
              value: pet.age.toString(),
            ),
            const DetailsText(
              field: "Owner Id",
              value: "",
            ),
            Text(pet.ownerId),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Album: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(onTap:(){
                    Get.to(()=>PhotoGallery(images: pet.images, videos: pet.videos,));
                  },child: const Icon(Icons.photo_album))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsText extends StatelessWidget {
  const DetailsText({
    super.key,
    required this.field,
    required this.value,
  });

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$field: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
