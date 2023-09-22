part of 'homepage_bloc.dart';

abstract class HomepageEvent {}

class HomepageSelectedEvent extends HomepageEvent {
  final int index;

  HomepageSelectedEvent(this.index);
}
