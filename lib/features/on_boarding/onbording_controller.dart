import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

class OnbordingController extends ChangeNotifier {
  final PageController pageController = PageController();
  bool islast = false;
  int currentIndex = 0;

  isLastOnbording(bool last) {
    islast = last;
    notifyListeners();
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onNextTap(OnBoardState onBoardState) {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.pushReplacement,
        page: () => const LoginScreen());
    /*  if (!onBoardState.isLastPage) {
      pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
       NavigationService.navigateTo(
              navigationMethod: NavigationMethod.pushReplacement,
              page: () => const LoginScreen());
    } */
  }
}
