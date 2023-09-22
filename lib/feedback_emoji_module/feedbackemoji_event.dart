part of 'feedbackemoji_bloc.dart';

class EmojiEvent {}

class EmojiSelectedEvent extends EmojiEvent {
  final int index;

  EmojiSelectedEvent(this.index);
}