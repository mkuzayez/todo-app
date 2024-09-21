import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color color;
  final TextOverflow overflow;
  final bool softWrap;
  final int maxLine;

  const AppText({
    super.key,
    required this.text,
    required this.style,
    this.color = Colors.white,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap = true,
    this.maxLine = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: color),
      overflow: overflow,
      softWrap: softWrap,
      maxLines: maxLine,
    );
  }
}
