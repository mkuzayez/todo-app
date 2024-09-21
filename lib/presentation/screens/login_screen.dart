import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/auth_textfield.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/widgets/prompt.dart';
import 'package:todo_app/theme/text.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 180),
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 180),
                AuthTextField(
                  controller: emailController,
                  label: 'Email',
                  style: customTextTheme.bodyLarge!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: passwordController,
                  label: 'Password',
                  style: customTextTheme.bodyLarge!,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                LargeButton(
                  textWidget: AppText(
                    text: 'Sign In',
                    style: customTextTheme.bodyLarge!,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            LogInEvent(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Prompt(
                  text: 'Don\'t have an account? ',
                  tappableText: 'Sign Up',
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/signup');
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  child: const SizedBox(),
                  listenWhen: (previous, current) => current == previous || current != previous,
                  listener: (context, state) {
                    if (state.state == AppState.authorized) {
                      Navigator.of(context).pushReplacementNamed('/home');
                    } else if (state.state == AppState.logInFailed) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'This account does not exists. Sign up a new one.',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
