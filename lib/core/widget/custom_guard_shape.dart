

import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:flutter/widgets.dart';

class CustomGuardShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4982383, 0);
    path_0.cubicTo(
        size.width * 0.6848440,
        size.height * 0.1074137,
        size.width * 0.8529833,
        size.height * 0.1584147,
        size.width * 0.9977286,
        size.height * 0.1464193);
    path_0.cubicTo(
        size.width * 1.023108,
        size.height * 0.6111654,
        size.width * 0.8345257,
        size.height * 0.8856852,
        size.width * 0.5002236,
        size.height * 1.000000);
    path_0.cubicTo(
        size.width * 0.1774574,
        size.height * 0.8928874,
        size.width * -0.01343182,
        size.height * 0.6300618,
        size.width * 0.0007422378,
        size.height * 0.1392171);
    path_0.cubicTo(
        size.width * 0.1705269,
        size.height * 0.1473226,
        size.width * 0.3370296,
        size.height * 0.1140137,
        size.width * 0.4982383,
        0);
    path_0.lineTo(size.width * 0.4982383, 0);
    path_0.lineTo(size.width * 0.4982383, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = ThemeColorLight.pinkColor;

    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
