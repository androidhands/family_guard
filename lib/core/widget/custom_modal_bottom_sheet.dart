import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomModalBottomSheet {
  static Future<dynamic> showModalBottomSheet({
    required BuildContext context,
    required Widget body,
    bool isDismissible = true,
    ShapeBorder? shape,
    bool expand = false,
    bool enableDrag = false,
    double? elevation,
    Color? backgroundColor,
    // String? title,
    // Widget? headerWidget,
    Color? barrierColor,
    Curve? animationCurve,
    double? height,
  }) async {
    // assert(title != null || headerWidget != null);
    return await showMaterialModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      shape: shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.br8),
                  topRight: Radius.circular(AppSizes.br8))),
      duration: const Duration(milliseconds: 200),
      expand: expand,
      enableDrag: enableDrag,
      elevation: elevation,
      backgroundColor:
          backgroundColor ?? Theme.of(context).bottomSheetTheme.backgroundColor,
      barrierColor: barrierColor,
      animationCurve: animationCurve,
      builder: (context) {
        return SizedBox(
            height: (height ?? 0) + (MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // title != null
                //     ? HeaderModalBottomSheetDefault(title: title)
                //     : headerWidget!,
                Expanded(child: body),
              ],
            ));
      },
    );
  }
}
