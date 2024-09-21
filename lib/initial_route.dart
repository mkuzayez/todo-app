import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.state == AppState.authorized) {
                Navigator.of(context).pushReplacementNamed('/home');
              } else if (state.state == AppState.logIn) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
