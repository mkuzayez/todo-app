import 'package:flutter/material.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    required this.textWidget,
    required this.backgroundColor,
    this.onPressed,
  });

  final AppText textWidget;
  final Color backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              backgroundColor,
            ),
          ),
          child: textWidget,
        ),
      ),
    );
  }
}
