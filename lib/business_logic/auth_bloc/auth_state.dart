part of 'auth_bloc.dart';

enum AppState {
  authorizing,
  logIn,
  authorized,
  logInFailed,
  signUp,
  signUpSucceeded,
  signUpFailed,
  passwordChangeSucceeded,
  passwordChangeFailed,
}

class AuthState extends Equatable {
  const AuthState(this.state);

  final AppState state;
  @override
  List<Object> get props => [state];
}
