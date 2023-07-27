import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_data/dark.dart';
import 'package:family_guard/core/global/theme/theme_data/light.dart';

enum AppTheme { light, dark }

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.light: getThemeDataLight,
  AppTheme.dark: getThemeDataDark
};
