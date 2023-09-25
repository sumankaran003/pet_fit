import 'package:cloud_firestore/cloud_firestore.dart';

class PetModel {
  final String name;
  final String breed;
  final String location;
  final String ownerId;
  final Timestamp dob;
  final String ownerDetails;
  //final int age;
  final List<String> images;
  final List<String> videos;

  PetModel({
    required this.name,
    required this.breed,
    required this.location,
    required this.ownerDetails,
    required this.ownerId,
    required this.dob,
    required this.images,
    required this.videos,
  });


  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      name: json['name'],
      breed: json['breed'],
      location: json['location'],
      ownerId: json['ownerId'],
      ownerDetails: json['ownerDetails'],
      dob: json['dob'],
      images: List<String>.from(json['images']),
      videos: List<String>.from(json['videos']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'breed': breed,
      'location': location,
      'ownerId': ownerId,
      'ownerDetails': ownerDetails,
      'dob': dob,
      'images': List<String>.from(images),
      'videos': List<String>.from(videos),
    };
  }
}
