import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import '../integrated_library/loading/build_loading_animation.dart';

class CustomLoadingIndicators {
  static Widget loadingAnimation({double? size,}) {
    return Center(
      child: LoadingAnimationWidget.beat(
        size: size??AppSizes.loadingIndicatorLargeSize,
      ),);
  }

  static Widget defaultLoading({double? size, Color? color}) {
    return SizedBox(
      width: size ?? AppSizes.loadingIndicatorLargeSize,
      height: size ?? AppSizes.loadingIndicatorLargeSize,
      child: Center(
          child: CircularProgressIndicator(
        strokeWidth: AppSizes.loadingIndicatorThick,
        color: color ?? Theme.of(Get.context!).progressIndicatorTheme.color,
      )),
    );
  }
}
