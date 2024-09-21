import 'package:flutter/material.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';

class TodoTextField extends StatefulWidget {
  const TodoTextField({
    super.key,
    this.label = "",
    required this.controller,
    required this.style,
    this.maxLine = 1,
    this.minLine = 1,
    this.expands = false,
    this.validator,
    this.initialValue,
  });

  final TextStyle style;
  final String label;
  final TextEditingController controller;
  final int? maxLine;
  final int? minLine;
  final bool? expands;
  final String? Function(String?)? validator;
  final String? initialValue;

  @override
  State<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends State<TodoTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: TextFormField(
        initialValue: widget.initialValue,
        validator: widget.validator,
        controller: widget.controller,
        minLines: widget.minLine,
        maxLines: widget.maxLine,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          label: AppText(
            text: widget.label,
            style: widget.style,
            color: Colors.white,
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
