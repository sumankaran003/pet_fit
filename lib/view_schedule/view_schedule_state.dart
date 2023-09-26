part of 'view_schedule_bloc.dart';

@immutable
abstract class ViewScheduleState {}

class ScheduleInitial extends ViewScheduleState {}

class ScheduleLoaded extends ViewScheduleState {
  final List<ActivityModel> activities;

  ScheduleLoaded(this.activities);
}

class ScheduleLoading extends ViewScheduleState {}

class ScheduleLoadingError extends ViewScheduleState {
  final String errorMessage;

  ScheduleLoadingError(this.errorMessage);
}
