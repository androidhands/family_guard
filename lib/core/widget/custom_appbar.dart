import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';

import '../global/theme/theme_color/theme_color_light.dart';

import 'images/custom_svg_image.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool canPop;
  final bool withTransparent;
  final bool withMenu;
  final bool withOutElevation;
  final void Function()? popOnPressed;
  final String? title;
  final bool centerTitle;
  final List<Widget> actions;
  final Color? popIconsColor;

  const CustomAppbar(
      {Key? key,
      this.canPop = true,
      this.withMenu = false,
      this.popOnPressed,
      this.title,
      this.centerTitle = true,
      this.actions = const <Widget>[],
      this.withTransparent = false,
      this.withOutElevation = false,
      this.popIconsColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: withTransparent
          ? ThemeColorLight.transparentColor
          : Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///Back Button
              if (canPop)
                CustomBackButton(
                  popOnPressed: popOnPressed,
                  color: popIconsColor,
                ),

              ///Title
              Expanded(
                  child: title != null
                      ? Align(
                          alignment: centerTitle
                              ? Alignment.center
                              : AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: centerTitle &&
                                    ((canPop && !withMenu && actions.isEmpty) ||
                                        (!canPop &&
                                            withMenu &&
                                            actions.isEmpty) ||
                                        (!canPop &&
                                            !withMenu &&
                                            actions.isNotEmpty))
                                ? EdgeInsetsDirectional.only(
                                    end:
                                        canPop && (actions.isEmpty || !withMenu)
                                            ? AppSizes.backButtonSizes +
                                                (AppSizes.pW5)
                                            : 0,
                                    start: !canPop &&
                                            (withMenu || actions.isNotEmpty)
                                        ? AppSizes.backButtonSizes +
                                            (AppSizes.pW5)
                                        : 0)
                                : EdgeInsets.zero,
                            child: CustomText(
                              title!,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: ThemeColorLight.pinkColor,
                                      fontSize: AppSizes.h5),
                              maxLines: 1,
                            ),
                          ))
                      : const SizedBox()),

              ///actions
              Row(
                mainAxisSize: MainAxisSize.min,
                children: withMenu
                    ? [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [...actions],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(end: AppSizes.pW5),
                          height: AppSizes.backButtonSizes,
                          width: AppSizes.backButtonSizes,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: CustomSvgImage(
                              path: AppAssets.menuIcon,
                              width: AppSizes.backButtonSizes,
                              height: AppSizes.backButtonSizes,
                              radius: BorderRadius.zero,
                            ),
                          ),
                        )
                      ]
                    : actions,
              ),
            ],
          ),
        )
      ],
      elevation: withOutElevation ? 0 : 3,
      shadowColor: Colors.black38,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight);
}

class CustomBackButton extends StatelessWidget {
  final void Function()? popOnPressed;
  final Color? color;

  const CustomBackButton({Key? key, this.popOnPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: AppSizes.pW5),
      width: AppSizes.backButtonSizes,
      height: AppSizes.backButtonSizes,
      child: IconButton(
        padding: EdgeInsets.zero,
        color: ThemeColorLight.whiteColor,
        constraints: const BoxConstraints(),
        onPressed: () {
          if (popOnPressed != null) {
            popOnPressed!();
          } else {
            NavigationService.goBack();
          }
        },
        icon: sl<BaseAppLocalizations>().isEnglish()
            ? CustomSvgImage(
                path: AppAssets.backSvg,
                color: color ?? ThemeColorLight.whiteColor,
                width: AppSizes.backButtonSizes,
                height: AppSizes.backButtonSizes,
                radius: BorderRadius.zero,
              )
            : Transform.rotate(
                angle: 180 * math.pi / 180,
                child: CustomSvgImage(
                  path: AppAssets.backSvg,
                  color: color ?? ThemeColorLight.whiteColor,
                  width: AppSizes.backButtonSizes,
                  height: AppSizes.backButtonSizes,
                  radius: BorderRadius.zero,
                )),
      ),
    );
  }
}
