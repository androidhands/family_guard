import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_sizes.dart';
import '../components/bottom_nav_bar_with_animation_component.dart';
import '../controller/home_control_provider.dart';
import '../widgets/floating_action_button_home_widget.dart';

class HomeControlScreen extends StatefulWidget {
  const HomeControlScreen({Key? key}) : super(key: key);

  @override
  State<HomeControlScreen> createState() => _HomeControlScreenState();
}

class _HomeControlScreenState extends State<HomeControlScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeControlProvider>(
      create: (context) =>
          HomeControlProvider(singleTickerProviderStateMixin: this),
      child: Consumer<HomeControlProvider>(
        builder: (context, provider, child) {
          return WillPopScope(
            onWillPop: provider.onGoBack,
            child: Scaffold(
              extendBody: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: provider.subScreenList[provider.currentIndex],
              bottomNavigationBar: Padding(
                padding:
                    EdgeInsets.only(bottom: Platform.isIOS ? AppSizes.pH5 : 0),
                child: BottomNavBarWithAnimationComponent(
                  scrollController: provider.scrollController,
                ),
              ),

              ///Floating Action Button
              floatingActionButton: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(
                  provider.animationController,
                ),
                child: FloatingActionButtonHomeWidget(
                  onPressed: () {
                    //provider.startAnimation();
                    provider.checkUserCountry();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
