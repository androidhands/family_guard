import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/home/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

import 'package:family_guard/core/services/navigation_service.dart';
import 'package:provider/provider.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../screens/no_network_screen.dart';

class ConnectivityService {
  /// `_isInitialized` is used to ensure that the listeners are only called once
  bool _isInitialized = false;
  bool canGoBack = true;

  /// Start listening to connectivity stream
  /// Connectivity stream is triggered whenever app connection to the internet method changed

   initializeConnectivityListeners() {
    if (_isInitialized) return;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult status) async {
      print("Connection status changed : $status");
      bool isConnected = ((status == ConnectivityResult.mobile) ||
          (status == ConnectivityResult.wifi));
      canGoBack = Get.previousRoute != '/';
      if (isConnected) {
        bool isCached = await getScreenToNavigate();
        if (canGoBack) {
          NavigationService.goBack();
        } else {
          // NavigationService.navigateTo(
          //     navigationMethod: NavigationMethod.pushReplacement,
          //     preventDuplicates: false,
          //     page: () => const HomeControlScreen());
          isCached
              ? NavigationService.navigateTo(
                  navigationMethod: NavigationMethod.pushReplacement,
                  preventDuplicates: false,
                  page: () => const HomeScreen())
              : NavigationService.navigateTo(
                  navigationMethod: NavigationMethod.pushReplacement,
                  preventDuplicates: false,
                  page: () => const LoginScreen());
        }
      } else {
        NavigationService.navigateTo(
            navigationMethod: NavigationMethod.push,
            page: () => const NoNetWorkScreen());
      }
    });

    _isInitialized = true;
  }


  Future<bool> getScreenToNavigate() async {
    return await Provider.of<MainProvider>(Get.context!, listen: false)
        .checkCashedUser();
  }


  Future<ConnectivityResult> isConnected() async {
    return await Connectivity().checkConnectivity();
  }
}
