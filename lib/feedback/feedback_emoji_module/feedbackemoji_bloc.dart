import 'package:bloc/bloc.dart';
part 'feedbackemoji_event.dart';
part 'feedbackemoji_state.dart';

class EmojiBloc extends Bloc<EmojiEvent, EmojiState> {
  EmojiBloc() : super(EmojiState(selectedIndex: 0)) {
    on<EmojiSelectedEvent>((event, emit) {
      emit(EmojiState(selectedIndex: event.index));
    });
  }
}
