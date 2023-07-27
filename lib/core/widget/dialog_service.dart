import 'package:flutter/material.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import '../utils/enums.dart';
import 'custom_dialog.dart';

class DialogWidget {
  static Future showCustomDialog(
      {required BuildContext context,
      String? title,
      String? buttonText,
      Function? onPressed,
      String? image,
      Widget? footer,
      bool withOutIconButton = false,
      String description = '',
      ShapeBorder? shape,
      Color? backgroundColor,
      Color? titleColor,
      Color? barrierColor,
      EdgeInsets? contentPadding,
      Widget? child,
      List<Widget>? actions,
      bool barrierDismissible = true,
      DialogWidgetState dialogWidgetState = DialogWidgetState.INFO}) async {
    return await showGeneralDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierLabel: '',
        transitionBuilder: (context, a1, a2, widget) => Transform.scale(
              scale: a1.value,
              child: WillPopScope(
                onWillPop: () => Future.value(barrierDismissible),
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    context: context,
                    title: title,
                    actions: actions,
                    image: image,
                    onPressed: onPressed ?? NavigationService.goBack,

                    description: description,
                    // backgroundColor: gt("themePrimaryColor"),
                    buttonText: buttonText,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.br20)),
                    child: child,
                  ),
                ),
              ),
            ),
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const SizedBox());
  }
}
