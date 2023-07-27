import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_dark.dart';


class CustomDateTimePicker {
  static Future<TimeOfDay?> showTime(
      {required BuildContext context, required TimeOfDay initialTime}) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: ThemeColorDark.backgroundColor),
          ),
          child: child!,
        );
      },
    );
  }
}
