part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  const SignUpEvent(this.email, this.password, this.name);
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInEvent(this.email, this.password);
}

class ChangePasswordEvent extends AuthEvent {
  final User user;
  final String newPassword;

  const ChangePasswordEvent(this.user, this.newPassword,);

  @override
  List<Object> get props => [user, newPassword];
}

class InitEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
