import 'package:flutter/widgets.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';


class CustomGradientBoxBorder extends BoxBorder {
  final LinearGradient gradient;
  final double width;
  final bool selected;

  const CustomGradientBoxBorder(
      {required this.gradient, this.width = 1.0, this.selected = false});

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  BorderSide get top => BorderSide.none;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  bool get isUniform => true;

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
        if (borderRadius != null) {
          _paintRRect(canvas, rect, borderRadius);
          return;
        }
        _paintRect(canvas, rect);
        break;
    }
  }

  void _paintRect(Canvas canvas, Rect rect) {
    canvas.drawRect(rect.deflate(width / 2), _getPaint(rect));
  }

  void _paintRRect(Canvas canvas, Rect rect, BorderRadius borderRadius) {
    final RRect rrect = borderRadius.toRRect(rect).deflate(width);
    canvas.drawRRect(rrect, _getPaint(rect));
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
                  colors: [ThemeColorLight.secondaryColor, ThemeColorLight.secondaryColor])
              .createShader(rect)
      ..style = PaintingStyle.stroke;
  }
}
