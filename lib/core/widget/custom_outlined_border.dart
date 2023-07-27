import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import '../global/theme/theme_color/theme_color_light.dart';

class CustomOutlinedBorder extends OutlinedBorder {
  final LinearGradient gradient;
  final double width;
  final bool selected;
  final double borderRaduis;

  const CustomOutlinedBorder(
      {required this.gradient, this.width = 1.0, this.selected = true,this.borderRaduis = AppSizes.e3});

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    return this;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    switch (shape) {
      case BoxShape.circle:
        assert(
          borderRadius == null,
        );
        _paintCircle(canvas, rect);
        break;
      case BoxShape.rectangle:
        /*  if (borderRadius != null) {
          _paintRRect(canvas, rect, BorderRadius.circular(AppSizes.e3));
          return;
        } */
        _paintRRect(canvas, rect, BorderRadius.circular(borderRaduis));
        break;
    }
  }

  void _paintRRect(Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final RRect rrect = borderRadius.toRRect(rect).deflate(width);
    canvas.drawRRect(rrect, _getPaint(rect));
  }

  void paintRect(Canvas canvas, Rect rect) {
    canvas.drawRect(rect.deflate(width / 2), _getPaint(rect));
  }

  void _paintCircle(Canvas canvas, Rect rect) {
    final Paint paint = _getPaint(rect);
    final double radius = (rect.shortestSide - width) / 2.0;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }

  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = selected
          ? gradient.createShader(rect)
          : const LinearGradient(
                  colors: [ThemeColorLight.thirdColor, ThemeColorLight.thirdColor])
              .createShader(rect)
      ..style = PaintingStyle.stroke;
  }
}
