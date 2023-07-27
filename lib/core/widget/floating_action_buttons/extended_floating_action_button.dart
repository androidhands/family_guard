import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';

import '../../global/theme/theme_color/theme_color_dark.dart';
import '../custom_loading_indicator.dart';
import '../images/custom_svg_image.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  final bool isExtended;
  final bool isLoading;
  final String? text;
  final String iconAsset;
  final String? fabType;

  const CustomFloatingActionButton(
      {Key? key,
      required this.onPressed,
      required this.isExtended,
      this.isLoading = false,
      this.text,
      required this.iconAsset,
      required this.fabType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExtended
        ? FloatingActionButton.extended(
            onPressed: () {
              onPressed.call();
            },
            extendedPadding: const EdgeInsets.all(0),
            label: AnimatedSwitcher(
                duration: const Duration(seconds: 5),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                            child: child,
                          ),
                        ),
                child: getFABChild(context)))
        : fabType == "small"
            ? FloatingActionButton.small(
                onPressed: () {
                  onPressed.call();
                },
                child: getFABChild(context),
              )
            : fabType == "normal"
                ? FloatingActionButton(
                    onPressed: () {
                      onPressed.call();
                    },
                    child: getFABChild(context),
                  )
                : FloatingActionButton.large(
                    onPressed: () {
                      onPressed.call();
                    },
                    child: getFABChild(context),
                  );
  }

  Widget getFABChild(BuildContext context) {
    return isLoading
        ? CustomLoadingIndicators.defaultLoading(
            color: ThemeColorDark.loadingColorElevatedButton,
            size: AppSizes.loadingIndicatorMediumSize,
          )
        : isExtended
            ? DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ThemeColorLight.blueColor,
                        ThemeColorLight.blueWhiteColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.pW5)),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  constraints:
                      const BoxConstraints(minHeight: 56.0, minWidth: 129.0),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: CustomSvgImage.icons(
                            path: iconAsset,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText.secondaryDisplaySmall(
                        text ?? '',
                        textStyle: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                color: ThemeColorDark.elevatedButtonTextColor,
                                fontSize: AppSizes.h5,
                                height: 1.2),
                      ),
                    ],
                  ),
                ),
              )
            : Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        ThemeColorLight.blueColor,
                        ThemeColorLight.blueWhiteColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.brMax)),
                child: Container(
                    padding: EdgeInsets.all(AppSizes.pH5),
                    constraints: BoxConstraints(
                      minHeight: fabType == "small"
                          ? 40
                          : fabType == "normal"
                              ? 56
                              : 96,
                      minWidth: fabType == "small"
                          ? 40
                          : fabType == "normal"
                              ? 56
                              : 96,
                    ),
                    child: CustomSvgImage.icons(
                      path: iconAsset,
                    )));
  }
}
