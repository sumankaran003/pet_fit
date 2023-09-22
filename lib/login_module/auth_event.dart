
abstract class AuthEvent {}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword(this.email, this.password);
}


class SignOut extends AuthEvent {}
