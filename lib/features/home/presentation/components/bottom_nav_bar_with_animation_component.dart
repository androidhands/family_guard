import 'package:family_guard/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../../core/integrated_library/bottom_navigation_bar/bottom_bar_creative.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/widget/images/custom_svg_image.dart';
import '../../utils/utils.dart';
import '../controller/home_control_provider.dart';

class BottomNavBarWithAnimationComponent extends StatefulWidget {
  final ScrollController scrollController;

  const BottomNavBarWithAnimationComponent(
      {Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<BottomNavBarWithAnimationComponent> createState() =>
      _BottomNavBarWithAnimationComponentState();
}

class _BottomNavBarWithAnimationComponentState
    extends State<BottomNavBarWithAnimationComponent> {
 /*  bool isVisible = true;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      ScrollDirection direction =
          widget.scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        show();
      } else if (direction == ScrollDirection.reverse) {
        hide();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});

    super.dispose();
  }

  void show() {
    setState(() {
      if (!isVisible) {
        setState(() {
          isVisible = !isVisible;
        });
      }
    });
  }

  void hide() {
    setState(() {
      if (isVisible) {
        setState(() {
          isVisible = !isVisible;
        });
      }
    });
  }
 */
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeControlProvider>(
      builder: (context, provider, child) {
        return AnimatedContainer(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 200),
          height:  AppSizes.bottomNavBarHeight ,
          child: Wrap(
            children: [
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.br30),
                      topRight: Radius.circular(AppSizes.br30)),
                ),
                elevation: 0.8,
                child: BottomBarCreative(
                  blur: 0.4,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.br30),
                      topRight: Radius.circular(AppSizes.br30)),
                  titleStyle: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: AppSizes.h7),
                  items: getBottomNavigationBarIList,
                  backgroundColor: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor!,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor!,
                  colorSelected: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor!,
                  indexSelected: provider.currentIndex,
                  onTap: (index) {
                    provider.changeCurrentIndex(index);
                  },
                ),
              )
            ],
          ),
        );

          /*   BottomAppBar(
          //bottom navigation bar on scaffold
          color: ThemeColorLight.pinkColor,
          shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin:
              5, //notche margin between floating button and bottom appbar
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: AppSizes.bottomNavBarHeight,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      CustomSvgImage(
                        path: AppAssets.mapSvg,
                        color: ThemeColorLight.whiteIconColor,
                        height: AppSizes.bottomBarIconHigh,
                        width: AppSizes.bottomBarIconWidth,
                      ),
                      CustomText(AppConstants.map,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: AppSizes.h8,
                                  color: ThemeColorLight.whiteColor))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSizes.bottomNavBarHeight,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      CustomSvgImage(
                        path: AppAssets.familySvg,
                        color: ThemeColorLight.whiteIconColor,
                        height: AppSizes.bottomBarIconHigh,
                        width: AppSizes.bottomBarIconWidth,
                      ),
                      CustomText(AppConstants.family,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: AppSizes.h8,
                                  color: ThemeColorLight.whiteColor))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ); */
      },
    );
  }
}
