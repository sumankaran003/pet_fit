part of 'create_schedule_bloc.dart';

@immutable
abstract class CreateScheduleState {}

class CreateScheduleInitial extends CreateScheduleState {}

class CreateScheduleLoading extends CreateScheduleState {}

class CreateScheduleSuccess extends CreateScheduleState {}

class CreateScheduleFailure extends CreateScheduleState {
  final String error;

  CreateScheduleFailure(this.error);
}
