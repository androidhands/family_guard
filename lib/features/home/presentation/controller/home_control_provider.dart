import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/check_verified_caller_id_usecase.dart';
import 'package:family_guard/features/emergency/presentation/screens/emergency_call_screen.dart';
import 'package:family_guard/features/emergency/presentation/screens/verify_caller_id_intro_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:family_guard/features/home/presentation/screens/home_screen.dart';

import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/background_dependency_injection.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../../family/presentation/screens/family_screen.dart';
import 'package:geolocator/geolocator.dart' as gl;

import 'package:geocoding/geocoding.dart' as gc;

class HomeControlProvider with ChangeNotifier {
  bool isMounted = true;
  ///var
  UserEntity? userEntity;
  final SingleTickerProviderStateMixin singleTickerProviderStateMixin;

  ///Constructor
  HomeControlProvider({required this.singleTickerProviderStateMixin}) {
    initializeDataSharedInSubScreen();
    
  }



  List<NotificationEntity>? notificationsList;
  int unReadNotificationsCount = 0;
  int currentIndex = 0;

  ///Loading
  bool isLoadingDataSharedInSubScreen = true;
  bool isLoadingHomeScreen = true;

   AnimationController? animationController;

  ///controller
  final ScrollController scrollController = ScrollController();

  ///sub Screen Bottom Navigation Bar
  List<Widget> subScreenList = const [
    ///Home
    HomeScreen(),

    ///More
    FamilyScreen(),
  ];

  ///initialize Data Shared In SubScreen in bottom nav bar
  initializeDataSharedInSubScreen() async {
    await Provider.of<MainProvider>(Get.context!, listen: false).getCachedUserCredentials();
    userEntity =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials;
    animationController = AnimationController(
      vsync: singleTickerProviderStateMixin,
      duration: const Duration(seconds: 5),
    );
    //    handlAppPermissions();
    //  await getMoreProfileData();
    // await getProfileDetails();
    // await getUnreadNotificationsCount();
  }

  ///change current Index
  changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  ///Navigate To LogIN Screen
  navigateToSignInScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.pushReplacement,
        page: () => const LoginScreen());
  }

  ///back
  Future<void> goBackExit() {
    return SystemNavigator.pop();
  }

  ///get emplpyee profile detaials
  Future<void> getProfileDetails() async {
    /*  Either<Failure, ProfileEntity> results =
        await sl<GetProfileUsecase>()(NoParameters());
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(l.message),
        buttonText: tr(AppConstance.ok),
      );
    }, (r) {
      profileEntity = r;
    }); */
  }

  Future<void> getUnreadNotificationsCount() async {
    /*   Either<Failure, int> results =
        await sl<GetUnReadCountUsecase>()(NoParameters());
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(l.message),
        buttonText: tr(AppConstance.ok),
      );
    }, (r) {
      unReadNotificationsCount = r;
    });
    notifyListeners(); */
  }

  void navigateToNotificationScreen() {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => const NotificationsScreen());
  }

  ///on go back
  Future<bool> onGoBack() {
    if (currentIndex == 1) {
      goBackExit();
    } else {
      changeCurrentIndex(1);
    }
    return Future.value(false);
  }

  @override
  void notifyListeners() {
    if (isMounted) super.notifyListeners();
  }

  @override
  void dispose() {
    isMounted = false;
    animationController?.dispose();
    super.dispose();
  }

  void handlAppPermissions() async {
    await [
      Permission.location,
      Permission.storage,

      //add more permission to request here.
    ].request().then((value) async {
      return value;
    });
  }

  bool isLoadingAnimation = false;
  void startAnimation() {
    log('start animation');
    if (animationController!.isAnimating) {
      isLoadingAnimation = false;
      animationController!.stop();
      notifyListeners();
    } else {
      isLoadingAnimation = true;
      animationController!.fling();
//animationController.forward();
      animationController!.repeat();

      /*  animationController.fling();
      animationController.repeat(); */

      notifyListeners();
    }
  }

  checkUserCountry() async {
    log(userEntity!.country);
    startAnimation();
    if (userEntity!.country == "US") {
      startAnimation();
      await checkVeriviedCallerId();
      // await checkUserIsInUS();
    } else {
      startAnimation();
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title:
              "The emergency calls working only in the United States, and you should located in the United Stated",
          buttonText: tr(AppConstants.ok));
    }
  }

  Future checkUserIsInUS() async {
    startAnimation();
    await gl.Geolocator.getCurrentPosition(
            desiredAccuracy: gl.LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((gl.Position position) async {
      gc.Placemark placemark = (await gc.placemarkFromCoordinates(
              position.latitude, position.longitude))
          .first;
      log('Map location ${placemark.isoCountryCode}');

      if (placemark.isoCountryCode == "US") {
        startAnimation();
        await checkVeriviedCallerId();
      } else {
        startAnimation();
        await DialogWidget.showCustomDialog(
            context: Get.context!,
            title:
                "The emergency calls working only in the United States, and you should located in the United Stated",
            buttonText: tr(AppConstants.ok));
      }
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  Future checkVeriviedCallerId() async {
    startAnimation();
    Either<Failure, bool> isCallerIdVerfied =
        await sl<CheckVerifiedCallerIdUsecase>()(userEntity!.apiToken!);
    isCallerIdVerfied.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      /*  log(r.toString());
      NavigationService.navigateTo(
          navigationMethod: NavigationMethod.push,
          page: () => const VerifyCallerIdIntroScreen()); */
      if (r) {
        NavigationService.navigateTo(
            navigationMethod: NavigationMethod.push,
            page: () => const EmergencyCallScreen());
      } else {
        NavigationService.navigateTo(
            navigationMethod: NavigationMethod.push,
            page: () => const VerifyCallerIdIntroScreen());
      }
    });
    startAnimation();
  }
}
