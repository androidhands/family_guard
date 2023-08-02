import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:family_guard/features/home/presentation/screens/home_screen.dart';

import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/presentation/screens/notifications_screen.dart';

import 'package:provider/provider.dart';

import '../../../../core/services/navigation_service.dart';
import '../../../authentication/domain/usecases/check_user_credentials_usecase.dart';
import '../../../authentication/domain/usecases/get_cached_user_credentials_usecase.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../../family/presentation/screens/family_screen.dart';

class HomeControlProvider with ChangeNotifier {
  bool isMounted = true;

  ///Constructor
  HomeControlProvider({
    required this.checkCashUser,
    required this.getCachedUserCredentialDataUseCase,
  }) {
    initializeDataSharedInSubScreen();
  }

  final UserEntity userEntity =
      Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

  ///var

  List<NotificationEntity>? notificationsList;
  int unReadNotificationsCount = 0;
  int currentIndex = 0;

  ///use case
  GetCachedUserCredentialsUsecase getCachedUserCredentialDataUseCase;
  CheckUserCredentialsUsecase checkCashUser;

  ///Loading
  bool isLoadingDataSharedInSubScreen = true;
  bool isLoadingHomeScreen = true;

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
    await getAuthenticationResultModel();
    //  await getMoreProfileData();
    // await getProfileDetails();
    // await getUnreadNotificationsCount();
  }

  Future<void> getAuthenticationResultModel() async {
    await Provider.of<MainProvider>(Get.context!, listen: false)
        .getCachedUserCredentials();
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
    super.dispose();
  }
}
