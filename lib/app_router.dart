import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:todo_app/business_logic/todo_item_cubit/todo_item_cubit.dart';
import 'package:todo_app/business_logic/todos_bloc/todo_items_bloc.dart';
import 'package:todo_app/data/credentials_repository.dart';
import 'package:todo_app/data/todo_repository.dart';
import 'package:todo_app/initial_route.dart';
import 'package:todo_app/presentation/screens/change_password_screen.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';
import 'package:todo_app/presentation/screens/login_screen.dart';
import 'package:todo_app/presentation/screens/settings_screen.dart';
import 'package:todo_app/presentation/screens/signup_screen.dart';
import 'package:todo_app/presentation/screens/todo_details_screen.dart';

class AppRouter {
  late TodoRepository todoRepository;
  late CredentialsRepository credentialsRepository;
  late AuthBloc authorizationBloc;
  late TodoBloc todoItemsBloc;

  AppRouter() {
    credentialsRepository = CredentialsRepository();
    authorizationBloc = AuthBloc(credentialsRepository);
    todoRepository = TodoRepository();
    todoItemsBloc = TodoBloc(todoRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authorizationBloc..add(InitEvent()),
            child: const InitialScreen(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: todoItemsBloc,
              ),
              BlocProvider.value(
                value: authorizationBloc,
              ),
            ],
            child: HomeScreen(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authorizationBloc,
            child: const LogInScreen(),
          ),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authorizationBloc,
            child: const SignUpScreen(),
          ),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authorizationBloc,
            child: const SettingsScreen(),
          ),
        );
      case '/passChange':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: authorizationBloc,
            child: const PasswordChangingScreen(),
          ),
        );
      case '/details':
        final args = settings.arguments as TodoDetailsArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: todoItemsBloc,
            child: TodoDetailsScreen(
              selectedTodoCubit: args.provider,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          ),
        );
    }
  }
}

class TodoDetailsArguments {
  final SelectedTodoCubit provider;

  TodoDetailsArguments({
    required this.provider,
  });
}
