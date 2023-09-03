import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/services/background_location_service.dart';
import 'package:family_guard/core/services/firebase_messaging_services.dart';
import 'package:family_guard/core/services/location_fetcher.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/usecases/check_user_credentials_usecase.dart';
import 'package:family_guard/features/notifications/domain/usecases/refresh_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/domain/usecases/get_cached_user_credentials_usecase.dart';
import '../../features/authentication/domain/usecases/sign_out_user_usecase.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_control_screen.dart';
import '../global/localization/app_localization.dart';
import '../local_data/shared_preferences_services.dart';
import '../services/connectivity_services.dart';
import '../services/dependency_injection_service.dart';
import '../services/navigation_service.dart';
import '../utils/app_constants.dart';
import '../widget/dialog_service.dart';

class MainProvider extends ChangeNotifier {
  final GetCachedUserCredentialsUsecase getCachedUserCredentialsUsecase;
  MainProvider({required this.getCachedUserCredentialsUsecase}) {
   
    initializeConnectivityChecker();
  }



  UserEntity? userCredentials;

  Future<UserEntity?> getCachedUserCredentials() async {
    Either<Failure, UserEntity?> results =
        await getCachedUserCredentialsUsecase();

    results.fold((l) {
      log('No cached user');
    //  userCredentials = null;
    }, (r) {
      log('cached user ${r?.mobile}');
      userCredentials = r;
    });
    return userCredentials;
  }

  Future<bool> checkUserLoggedIn() async {
    bool cached = await checkCashedUser();
    //  User? user = await FirebaseAuth.instance.authStateChanges().first;
    return cached; //user != null && cached;
  }

  Future initializeConnectivityChecker() async {
    getCachedUserCredentials();
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
    await checkUserLoggedIn().then((isCached) async {
      log('initialized cached is cached $isCached');
    
        if (isCached) {
          NavigationService.navigateTo(
              navigationMethod: NavigationMethod.pushReplacement,
              page: () => const HomeControlScreen());
          await sl<ConnectivityService>().initializeConnectivityListeners();
          String? token = await sl<FirebaseMessagingServices>().deviceToken();
          log(token!);
          await sl<RefreshTokenUsecase>()(token);
        } else {
          NavigationService.navigateTo(
              navigationMethod: NavigationMethod.pushReplacement,
              page: () => const LoginScreen());
        }
      
    });
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

  ///check if exist Cashed User
  Future<bool> checkCashedUser() async {
    bool result = (await sl<CheckUserCredentialsUsecase>()()).fold((l) {
      return false;
    }, (r) {
      return r;
    });
    return result;
  }
}
