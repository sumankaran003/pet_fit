class FeedBackModel {
  final String emoji;
  final String category;
  final String feedbackText;
  final String userId;
  final String timeStamp;

  FeedBackModel({
    required this.emoji,
    required this.category,
    required this.feedbackText,
    required this.userId,
    required this.timeStamp
  });

  factory FeedBackModel.fromJson(Map<String, dynamic> json) {
    return FeedBackModel(
      emoji: json['emoji'],
      category: json['category'],
      feedbackText: json['feedbackText'],
      userId: json['userId'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emoji': emoji,
      'category': category,
      'feedbackText': feedbackText,
      'userId': userId,
      'timeStamp': timeStamp,
    };
  }

}
