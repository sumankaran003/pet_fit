import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:pet_fit/models/ActivityModel.dart';

part 'create_schedule_event.dart';
part 'create_schedule_state.dart';

class CreateScheduleBloc
    extends Bloc<CreateScheduleEvent, CreateScheduleState> {
  CreateScheduleBloc() : super(CreateScheduleInitial()) {
    on<AddScheduleEvent>((event, emit) {
      try {
        emit(CreateScheduleLoading());
        addActivity("5wtvvCDR9N8OSfx5Mlin", event.activityModel);
        emit(CreateScheduleSuccess());
      } catch (e) {
        emit(CreateScheduleFailure(e.toString()));
      }
    });
  }

  Future<void> addActivity(
      String petListDocumentId, ActivityModel activityData) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference petListCollection = firestore.collection('pets');

    DocumentReference petDocument = petListCollection.doc(petListDocumentId);

    CollectionReference activitiesCollection =
        petDocument.collection('activities');

    await activitiesCollection
        .add(activityData.toJson())
        .then((DocumentReference document) {})
        .catchError((error) {});
  }
}
