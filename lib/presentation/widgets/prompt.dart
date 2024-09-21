import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/theme/text.dart';

class Prompt extends StatefulWidget {
  const Prompt({
    super.key,
    required this.text,
    required this.tappableText,
    required this.onTap,
  });

  final String text;
  final String tappableText;
  final void Function()? onTap;

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: widget.text,
          style: customTextTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          children: [
            TextSpan(
              text: widget.tappableText,
              style: customTextTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.onTap!();
                },
            ),
          ],
        ),
      ),
    );
  }
}
