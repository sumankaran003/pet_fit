import 'package:bloc/bloc.dart';

part 'feedbackchip_event.dart';
part 'feedbackchip_state.dart';

class ChipBloc extends Bloc<ChipEvent, ChipState> {
  ChipBloc() : super(ChipState(selectedIndex: 0)) {
    on<ChipSelectedEvent>((event, emit) {
      emit(ChipState(selectedIndex: event.index));
    });
  }
}
