import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_fit/models/ActivityModel.dart';
import 'package:pet_fit/models/product_model.dart';
import 'package:pet_fit/screens/pet_details_screen.dart';
import 'package:pet_fit/models/pet_model.dart';

import 'models/age_model.dart';

Widget proceedButton(String buttonText) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.deepPurple),
        width: Get.width,
        height: 50,
        child: Center(
            child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ))),
  );
}

Widget petTiles(PetModel pet) {
  return GestureDetector(
    onTap: () {
      Get.to(() => PetDetailsScreen(pet: pet));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              pet.images[0],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${pet.name}"),
                Text("Breed: ${pet.breed}"),
                Text("Location: ${pet.location}"),
                SizedBox(width: Get.width*0.5, child: Text("Age: ${calculateAge(pet.dob.millisecondsSinceEpoch)}", )),
              ]),
        ],
      ),
    ),
  );
}

Widget activityTiles(ActivityModel activity) {

  DateTime selectedDateTime=activity.activityTime.toDate();
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [


        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${activity.name}"),
              Text("Notes: ${activity.notes}"),
              Text("Date: ${selectedDateTime.day}:${selectedDateTime.month}:${selectedDateTime.year}  Time: ${selectedDateTime.hour}:${selectedDateTime.minute}:${selectedDateTime.second}"),
              ]),
      ],
    ),
  );
}

Widget productTiles(ProductModel product) {
  return GestureDetector(
    onTap: () {
      //  Get.to(()=>ProductDetailsScreen(product: product));
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${product.name}"),
                Text("Quantity Available: ${product.availableQuantity}"),
                Text("Price: ${product.cost}"),
              ]),
        ],
      ),
    ),
  );
}
