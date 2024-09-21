import 'package:flutter/material.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    this.controller,
    this.label = "",
    required this.style,
    this.maxLine = 1,
    this.isPassword = false,
    this.expands = false,
    this.validator,
    this.initialValue,
  });

  final String label;
  final TextStyle style;
  final TextEditingController? controller;
  final int? maxLine;
  final bool isPassword;
  final bool expands;
  final String? Function(String?)? validator;
  final String? initialValue;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool isObscure;
  @override
  void initState() {
    isObscure = widget.isPassword;
    super.initState();
  }

  void toggleVisibility() {
    setState(
      () {
        isObscure = !isObscure;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextFormField(
        initialValue: widget.initialValue,
        obscureText: isObscure,
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLine,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          label: AppText(
            text: widget.label,
            style: widget.style,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: toggleVisibility,
                  child: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
