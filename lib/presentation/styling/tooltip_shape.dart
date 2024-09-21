import 'package:flutter/material.dart';

class CustomToolTipShape extends ShapeBorder {
  final bool usePadding;

  const CustomToolTipShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(top: usePadding ? 16 : 0);
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft + const Offset(0, 15), rect.bottomRight);

    return Path()
      ..moveTo(rect.topCenter.dx, rect.topCenter.dy)
      ..relativeLineTo(11, -10)
      ..relativeLineTo(11, 10)
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(rect.height / 3),
        ),
      )
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}



class CustomDetailsToolTipShape extends ShapeBorder {
  final bool usePadding;

  const CustomDetailsToolTipShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(top: usePadding ? 16 : 0);
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft + const Offset(0, 15), rect.bottomRight);

    return Path()
      ..moveTo(rect.topCenter.dx - 7, rect.topCenter.dy)
      ..relativeLineTo(9, -10)
      ..relativeLineTo(9, 10)
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(rect.height / 3),
        ),
      )
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
