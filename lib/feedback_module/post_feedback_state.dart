part of 'post_feedback_bloc.dart';

@immutable
abstract class PostFeedbackState {}

class PostFeedbackInitial extends PostFeedbackState {}

class PostFeedbackLoading extends PostFeedbackState {}

class PostFeedbackSuccess extends PostFeedbackState {}

class PostFeedbackFailure extends PostFeedbackState {
  final String error;

  PostFeedbackFailure(this.error);
}
