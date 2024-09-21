import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/credentials_repository.dart';
import 'package:todo_app/data/models/user/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CredentialsRepository credentialsRepository;

  AuthBloc(this.credentialsRepository)
      : super(const AuthState(AppState.authorizing)) {
    on<InitEvent>(onInitState);
    on<SignUpEvent>(onSignUp);
    on<LogInEvent>(onLogIn);
    on<LogOutEvent>(onLogOut);
    on<ChangePasswordEvent>(onChangePassword);
  }

  Future<void> onInitState(InitEvent event, Emitter<AuthState> emit) async {
    try {
      User? sessionUser = credentialsRepository.getSessionUser();
      if (sessionUser != null) {
        emit(
          const AuthState(
            AppState.authorized,
          ),
        );
      } else {
        emit(
          const AuthState(
            AppState.logIn,
          ),
        );
      }
    } catch (e) {
      emit(
        const AuthState(
          AppState.logIn,
        ),
      );
    }
  }

  Future<void> onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    if (credentialsRepository.userExists(
      event.email,
    )) {
      emit(
        const AuthState(
          AppState.signUpFailed,
        ),
      );
      return;
    }

    final newUser = User(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    await credentialsRepository.signUpUser(newUser);
    emit(
      const AuthState(
        AppState.signUpSucceeded,
      ),
    );
  }

  Future<void> onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    User? storedUser = credentialsRepository.getUser(event.email);

    if (storedUser != null && storedUser.password == event.password) {
      await credentialsRepository.setSessionUser(
        User(
          name: storedUser.name,
          email: storedUser.email,
          password: storedUser.password,
        ),
      );
      emit(
        const AuthState(
          AppState.authorized,
        ),
      );
    } else {
      emit(
        const AuthState(
          AppState.logInFailed,
        ),
      );
      emit(
        const AuthState(
          AppState.logIn,
        ),
      );
    }
  }

  Future<void> onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await credentialsRepository.deleteSessionUser();
    emit(
      const AuthState(
        AppState.logIn,
      ),
    );
  }

  Future<void> onChangePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    if (event.user.password == event.newPassword) {
      emit(
        const AuthState(
          AppState.passwordChangeFailed,
        ),
      );
      return;
    } else {
      await credentialsRepository.changePassword(event.user, event.newPassword);
      emit(
        const AuthState(
          AppState.passwordChangeSucceeded,
        ),
      );
    }
  }
}
