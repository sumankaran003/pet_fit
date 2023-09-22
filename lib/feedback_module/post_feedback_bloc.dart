import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_fit/models/feedback_model.dart';

part 'post_feedback_event.dart';
part 'post_feedback_state.dart';

class PostFeedbackBloc extends Bloc<PostFeedbackEvent, PostFeedbackState> {
  PostFeedbackBloc() : super(PostFeedbackInitial()) {
    on<SubmitFeedbackEvent>((event, emit) {
      emit(PostFeedbackLoading());
      try {
        addFeedback(event.feedbackModel);
        emit(PostFeedbackSuccess());
      } catch (e) {
        emit(PostFeedbackFailure(e.toString()));
      }
    });
  }

  Future<void> addFeedback(FeedBackModel feedbackModel) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final CollectionReference feedbackCollection =
          FirebaseFirestore.instance.collection('feedback');
      final DateTime now = DateTime.now();
      final int timestamp = now.millisecondsSinceEpoch;

      await feedbackCollection.add({
        'userId': user?.uid,
        'feedbackText': feedbackModel.feedbackText,
        'emoji': feedbackModel.emoji,
        'category': feedbackModel.category,
        'timestamp': timestamp.toString(),
      });
    } catch (e) {
      //print('$e');
    }
  }
}
