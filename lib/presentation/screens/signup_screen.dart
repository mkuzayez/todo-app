import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/auth_textfield.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/widgets/prompt.dart';
import 'package:todo_app/theme/text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpFullNameController =
      TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpPasswordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool passwordConfirmation() {
    return signUpPasswordController.text ==
        signUpPasswordConfirmationController.text;
  }

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
                const SizedBox(height: 80),
                AuthTextField(
                  controller: signUpEmailController,
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
                  controller: signUpFullNameController,
                  label: 'Full Name',
                  style: customTextTheme.bodyLarge!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Please enter your full name';
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: signUpPasswordController,
                  label: 'Password',
                  style: customTextTheme.bodyLarge!,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: signUpPasswordConfirmationController,
                  label: 'Confirm Password',
                  style: customTextTheme.bodyLarge!,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (!passwordConfirmation()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                LargeButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textWidget: AppText(
                    text: 'Sign Up',
                    style: customTextTheme.bodyLarge!,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        SignUpEvent(
                          signUpEmailController.text,
                          signUpPasswordController.text,
                          signUpFullNameController.text,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                Prompt(
                  text: 'Have an account? ',
                  tappableText: 'Sign in',
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  child: const SizedBox(),
                  listener: (context, state) {
                    if (state.state == AppState.signUpSucceeded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Account created successfully.',
                          ),
                        ),
                      );
                      Navigator.of(context).pushReplacementNamed('/login');
                    } else if (state.state == AppState.signUpFailed) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'This email already exists.',
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
