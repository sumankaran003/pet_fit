part of 'create_schedule_bloc.dart';

@immutable
abstract class CreateScheduleEvent {}

class AddScheduleEvent extends CreateScheduleEvent {
  final ActivityModel activityModel;

  AddScheduleEvent(this.activityModel);
}
