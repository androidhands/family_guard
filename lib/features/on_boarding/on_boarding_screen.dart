import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/features/authentication/presentation/screens/login_screen.dart';
import 'package:family_guard/features/on_boarding/onbording_controller.dart';
import 'package:family_guard/features/on_boarding/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OnbordingController(),
        builder: (context, child) {
          return Consumer<OnbordingController>(
              builder: (context, provider, child) {
            return Scaffold(
              body: OnBoard(
                pageController: provider.pageController,
                // Either Provide onSkip Callback or skipButton Widget to handle skip state
                onSkip: () {
                  NavigationService.navigateTo(
                      navigationMethod: NavigationMethod.pushReplacement,
                      page: () => const LoginScreen());
                },
                // Either Provide onDone Callback or nextButton Widget to handle done state
                onDone: () {
                  NavigationService.navigateTo(
                      navigationMethod: NavigationMethod.pushReplacement,
                      page: () => const LoginScreen());
                  // print('done tapped');
                },
                onBoardData: onBoardData,
                titleStyles: const TextStyle(
                  color: ThemeColorLight.pinkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.15,
                ),
                descriptionStyles: TextStyle(
                  fontSize: 16,
                  color: Colors.brown.shade300,
                ),
                pageIndicatorStyle: const PageIndicatorStyle(
                  width: 100,
                  inactiveColor: ThemeColorLight.pinkColor,
                  activeColor:  ThemeColorLight.pinkColor,
                  inactiveSize: Size(8, 8),
                  activeSize: Size(12, 12),
                ),
                // Either Provide onSkip Callback or skipButton Widget to handle skip state
                skipButton: TextButton(
                  onPressed: () {
                    NavigationService.navigateTo(
                        navigationMethod: NavigationMethod.pushReplacement,
                        page: () => const LoginScreen());
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: ThemeColorLight.pinkColor,),
                  ),
                ),
                // Either Provide onDone Callback or nextButton Widget to handle done state
                nextButton: OnBoardConsumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(onBoardStateProvider);
                    return InkWell(
                      onTap: () => provider.onNextTap(state),
                      child: Container(
                        width: 230,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [ ThemeColorLight.pinkColor,  ThemeColorLight.pinkWhiteColor],
                          ),
                        ),
                        child: Text(
                          state.isLastPage ? "Done" : "Next",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          });
        });
  }
}
