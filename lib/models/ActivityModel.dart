import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final String name;
  final String notes;
  final Timestamp activityTime;

  ActivityModel({
    required this.name,
    required this.notes,
    required this.activityTime,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      name: json['name'] ?? '',
      notes: json['notes'] ?? '',
      activityTime: json['activityTime'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'notes': notes,
      'activityTime': activityTime,
    };
  }
}
