import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:todo_app/data/models/user/user.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/presentation/custom_widgets/auth_textfield.dart';
import 'package:todo_app/theme/text.dart';

class PasswordChangingScreen extends StatefulWidget {
  const PasswordChangingScreen({super.key});

  @override
  State<PasswordChangingScreen> createState() => PasswordChangingScreenState();
}

class PasswordChangingScreenState extends State<PasswordChangingScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  late User user;
  late String email;

  @override
  void initState() {
    super.initState();
    final Box sessionBox = Hive.box('sessionBox');
    user = sessionBox.get('sessionUser');
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 94),
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 180),
                AuthTextField(
                  controller: newPasswordController,
                  label: 'New Password',
                  style: customTextTheme.bodyLarge!,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: newPasswordConfirmationController,
                  label: 'Confirm New Password',
                  style: customTextTheme.bodyLarge!,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                LargeButton(
                  textWidget: AppText(
                    text: 'Change Password',
                    style: customTextTheme.bodyLarge!,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            ChangePasswordEvent(
                              user,
                              newPasswordController.text,
                            ),
                          );
                    }
                  },
                ),
                BlocListener<AuthBloc, AuthState>(
                  listenWhen: (previous, current) => previous == current || previous != current,
                  child: const SizedBox(),
                  listener: (context, state) {
                    if (state.state == AppState.passwordChangeSucceeded) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password changed successfully.',
                          ),
                        ),
                      );
                    } else if (state.state == AppState.passwordChangeFailed) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'The new password matches the old one.',
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
