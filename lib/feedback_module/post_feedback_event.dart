part of 'post_feedback_bloc.dart';

abstract class PostFeedbackEvent {}

class SubmitFeedbackEvent extends PostFeedbackEvent {
  final FeedBackModel feedbackModel;

  SubmitFeedbackEvent(this.feedbackModel);
}
