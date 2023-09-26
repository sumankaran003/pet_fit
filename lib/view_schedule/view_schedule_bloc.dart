import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:pet_fit/models/ActivityModel.dart';

part 'view_schedule_event.dart';
part 'view_schedule_state.dart';

class ViewScheduleBloc extends Bloc<ViewScheduleEvent, ViewScheduleState> {
  ViewScheduleBloc() : super(ScheduleInitial()) {
    on<FetchSchedule>((event, emit) async {
      emit(ScheduleLoading());
      try {
        List<ActivityModel> activities =  await getActivities(event.petId);

        emit(ScheduleLoaded(activities));
      } catch (e) {
        emit(ScheduleLoadingError(e.toString()));
      }


    });
  }

  Future<List<ActivityModel>> getActivities(String petId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection('pets')
        .doc(petId)
        .collection("activities")
        .get();

    return snapshot.docs
        .map(
            (doc) => ActivityModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
