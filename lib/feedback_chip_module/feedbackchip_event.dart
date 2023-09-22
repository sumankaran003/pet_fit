part of 'feedbackchip_bloc.dart';

class ChipEvent {}

class ChipSelectedEvent extends ChipEvent {
  final int index;

  ChipSelectedEvent(this.index);
}
