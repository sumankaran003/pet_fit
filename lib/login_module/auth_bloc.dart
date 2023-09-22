import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignInWithEmailAndPassword>((event, emit) async {
      try {
        emit(SignInLoading());
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        if (userCredential.user != null) {
          final User? user = userCredential.user;
          if (user != null) {
            emit(Authenticated(user));
          } else {
            emit(Unauthenticated("Something went wrong"));
          }
        } else {
          emit(Unauthenticated("Something went wrong"));
        }
      } catch (e) {
        // print(e);
        emit(Unauthenticated(e.toString()));
      }
    });

    on<SignOut>((event, emit) async {
      emit(SignInLoading());
      await _auth.signOut();
      emit(Unauthenticated("Logged Out"));
    });
  }
}
