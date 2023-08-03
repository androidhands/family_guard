import 'dart:developer';

import 'package:family_guard/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';

import '../global/theme/app_theme.dart';
import '../local_data/shared_preferences_services.dart';
import '../utils/app_assets.dart';
import '../utils/utils.dart';
import 'firebase_messaging_services.dart';

class ServiceInitializer {
  ServiceInitializer._();
  static final ServiceInitializer instance = ServiceInitializer._();
  factory ServiceInitializer() => instance;
  static late Locale locale;
  static late AppTheme savedAppTheme;
  initializeSettings() async {
    await initializeDependencyInjection();
    List futures = [
      initializeStatusBarColor(),
      initializeScreenOrientation(),
      getSavedLocale(),
      getSavedAppTheme(),
      initializeFirebase(),
     // initializeNotifications()
    ];
    await Future.wait<dynamic>([...futures]);
  }

  initializeDependencyInjection() async {
    await DependencyInjectionServices().init();
  }

  initializeStatusBarColor() async {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  initializeScreenOrientation() async {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  Future getSavedLocale() async {
    locale = await sl<BaseAppLocalizations>().getUserStoredLocale();
  }

  Future getSavedAppTheme() async {
    savedAppTheme = await sl<SharedPreferencesServices>()
        .getData(key: AppConstants.storedThemeApp, dataType: DataType.int)
        .then(
            (value) => value == null ? AppTheme.light : AppTheme.values[value]);
  }
  Future initializeFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await initializeNotifications();
  }
  
  Future initializeNotifications() async {
    await sl<FirebaseMessagingServices>().initializeNotifications();
  }

  Future cacheDefaultImages() async {
    List futures = [
      preCachedSvgImage(AppAssets.profileSvg),
      preCachedSvgImage(AppAssets.home),
      preCachedSvgImage(AppAssets.profileSvg),
      preCachedSvgImage(AppAssets.calenderSvg),
      preCachedSvgImage(AppAssets.chatSvg),
      preCachedSvgImage(AppAssets.moreSvg),
    ];
    await Future.wait<dynamic>([...futures]);
    log("cacheDefaultImages Done");
  }
}
