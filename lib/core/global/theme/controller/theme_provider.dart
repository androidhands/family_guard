import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/app_theme.dart';
import 'package:family_guard/core/global/theme/domain/usecases/save_theme_usecase.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData;
  AppTheme appTheme;

  ThemeProvider({required this.themeData, required this.appTheme});

  changeTheme(AppTheme appTheme, ThemeData themeData) async {
    this.themeData = themeData;
    this.appTheme = appTheme;

    await SaveThemeUseCase(baseThemeRepository: sl()).call(appTheme.index);
    notifyListeners();
  }
}
