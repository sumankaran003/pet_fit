import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_fit/create_schedule/create_schedule_screen.dart';
import 'package:pet_fit/models/age_model.dart';
import 'package:pet_fit/models/pet_model.dart';
import 'package:pet_fit/screens/photo_gallery.dart';
import 'package:pet_fit/utilMethods.dart';
import 'package:pet_fit/view_schedule/view_schedule.dart';
import 'package:pet_fit/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetModel pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  pet.images[0],
                  height: Get.width * 0.75,
                  width: Get.width * 0.85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10,),
              DetailsText(
                field: "Name",
                value: pet.name,
              ),
              const SizedBox(height: 10,),
              DetailsText(
                field: "Breed",
                value: pet.breed,
              ),
              const SizedBox(height: 10,),
              DetailsText(
                field: "Location",
                value: pet.location,
              ),
              const SizedBox(height: 10,),
              DetailsText(
                field: "Age",
                value: calculateAge(pet.dob.millisecondsSinceEpoch),
              ),
              const SizedBox(height: 10,),
              DetailsText(
                field: "Owner Id",
                value: pet.ownerId,
              ),
              const SizedBox(height: 10,),
              const Text(
                "Owner Details: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Text(pet.ownerDetails),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Album: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => PhotoGallery(
                              images: pet.images,
                              videos: pet.videos,
                            ));
                      },
                      child: const Icon(Icons.photo_album))
                ],
              ),
              const SizedBox(height: 20,),

               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Schedule: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: (){

                      Get.to(()=>const CreateSchedule());

                    },
                    child: const Column(
                      children: [
                        Icon(Icons.calendar_month,),
                        Text("Create")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> ViewSchedule(petId: "5wtvvCDR9N8OSfx5Mlin"));
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.list_alt),
                        Text("View")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    var url = Uri.parse('tel:+917001855752');

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      showSnackBar("Something went wrong", "", "failure");
                    }
                  },
                  child: proceedButton("Call")),
              const SizedBox(
                height: 10,
              )
            ],
          ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$field: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          width: Get.width*0.5,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
