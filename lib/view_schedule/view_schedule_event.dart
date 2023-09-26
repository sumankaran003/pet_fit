part of 'view_schedule_bloc.dart';

@immutable
abstract class ViewScheduleEvent {}

class FetchSchedule extends ViewScheduleEvent {
  final String petId;

  FetchSchedule(this.petId);
}