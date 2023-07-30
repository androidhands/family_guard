import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/domain/usecases/get_cached_user_credentials_usecase.dart';
import '../../features/authentication/domain/usecases/sign_out_user_usecase.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../global/localization/app_localization.dart';
import '../local_data/shared_preferences_services.dart';
import '../services/connectivity_services.dart';
import '../services/dependency_injection_service.dart';
import '../services/navigation_service.dart';
import '../utils/app_constants.dart';
import '../widget/dialog_service.dart';

class MainProvider extends ChangeNotifier {
  MainProvider() {
    initializeConnectivityChecker();
  }

  late UserEntity? userCredentials;

  Future<bool> getCachedUserCredentials() async {
    Either<Failure, UserEntity?> results =
        await sl<GetCachedUserCredentialsUsecase>()();
    bool cached = false;
    results.fold((l) {
      log('No cached user');
      userCredentials = null;
      cached = false;
    }, (r) {
      userCredentials = r;
      cached = r != null;
    });
    return cached;
  }

  Future<bool> checkUserLoggedIn() async {
    bool cached = await getCachedUserCredentials();
    User? user = await FirebaseAuth.instance.authStateChanges().first;
    return user != null && cached;
  }

  Future initializeConnectivityChecker() async {
    String? locale = await sl<SharedPreferencesServices>()
        .getData(key: AppConstants.userStoredLocale, dataType: DataType.string);
    if (locale == null) {
      String defaultLocale = Platform.localeName.split('_')[0];
      log(defaultLocale);
      sl<BaseAppLocalizations>().changeLocale(languageCode: defaultLocale);
    } else {
      sl<BaseAppLocalizations>().changeLocale(languageCode: locale);
    }
    ConnectivityResult connectivityResult =
        await sl<ConnectivityService>().isConnected();
    bool isConnected = (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
    bool isCached = await checkUserLoggedIn();

    if (isConnected) {
      isCached
          ? NavigationService.navigateTo(
              navigationMethod: NavigationMethod.pushReplacement,
              page: () => const HomeScreen())
          : NavigationService.navigateTo(
              navigationMethod: NavigationMethod.pushReplacement,
              page: () => const LoginScreen());
    } else {
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: () => const HomeScreen());
      /*  NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: () => const NoNetWorkScreen()); */
    }

    await sl<ConnectivityService>().initializeConnectivityListeners();
  }

  logoutUser() async {
    var res = await sl<SignOutUserUsecase>()();
    res.fold((l) async {
      await DialogWidget.showCustomDialog(
          title: l.message,
          buttonText: tr(AppConstants.ok),
          context: Get.context!);
    }, (r) {
      if (r) {
        NavigationService.goBack();
        NavigationService.offAll(page: () => const LoginScreen());
        /* if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        } */
      }
    });
  }
}
