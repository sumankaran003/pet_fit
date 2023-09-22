class PetModel {
  final String name;
  final String breed;
  final String location;
  final String ownerId;
  final int age;
  final List<String> images;
  final List<String> videos;

  PetModel({
    required this.name,
    required this.breed,
    required this.location,
    required this.ownerId,
    required this.age,
    required this.images,
    required this.videos,
  });


  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      name: json['name'],
      breed: json['breed'],
      location: json['location'],
      ownerId: json['ownerId'],
      age: json['age'],
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
      'age': age,
      'images': List<String>.from(images),
      'videos': List<String>.from(videos),
    };
  }
}
