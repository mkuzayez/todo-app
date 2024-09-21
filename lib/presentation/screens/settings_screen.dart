import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:todo_app/presentation/custom_widgets/large_button.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/theme/text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final user = Hive.box('sessionBox').values.first;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/illustration.png"),
              const SizedBox(height: 180),
              SizedBox(
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "Full Name",
                          style: customTextTheme.bodyLarge!,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        const Spacer(),
                        AppText(
                          text: user.name,
                          style: customTextTheme.headlineLarge!,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppText(
                          text: "Email",
                          style: customTextTheme.bodyLarge!,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        const Spacer(),
                        AppText(
                          text: user.email,
                          style: customTextTheme.bodyLarge!,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppText(
                          text: "Password",
                          style: customTextTheme.bodyLarge!,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/passChange');
                          },
                          child: AppText(
                            text: "Change Password",
                            style: customTextTheme.bodyLarge!,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              LargeButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                textWidget: AppText(
                  text: "Log out",
                  style: customTextTheme.bodyLarge!,
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        LogOutEvent(),
                      );
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
