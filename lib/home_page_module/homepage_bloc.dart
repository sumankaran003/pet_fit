import 'package:bloc/bloc.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomepageState(selectedIndex: 0)) {
    on<HomepageSelectedEvent>((event, emit) {
      emit(HomepageState(selectedIndex: event.index));
    });
  }
}
