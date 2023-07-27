import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../global/theme/theme_color/theme_color_light.dart';

class CustomPinCodeTextField extends StatelessWidget {
  final Future<void> Function(String)? onDone;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const CustomPinCodeTextField(
      {this.controller, Key? key, this.onDone, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autoDisposeControllers: false,
      controller: controller,
      autoDismissKeyboard: true,
      enableActiveFill: true,
      autoFocus: true,
      animationDuration: const Duration(milliseconds: 150),
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      appContext: context,
      onChanged: (String value) {
        if (onChanged != null) onChanged!(value);
      },
      onCompleted: (String value) async {
        if (onDone != null) {
          await onDone!(value);
        }
      },
      length: 4,
      obscureText: false,
      animationType: AnimationType.scale,
      textStyle: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontSize: AppSizes.h3, fontWeight: FontWeight.w600),
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(AppSizes.br20),
          activeColor: ThemeColorLight.transparentColor,
          inactiveColor: ThemeColorLight.transparentColor,
          borderWidth: 0.5,
          selectedFillColor: Theme.of(context).colorScheme.background,
          selectedColor: Theme.of(context).highlightColor,
          fieldHeight: AppSizes.heightPinCode,
          fieldWidth: AppSizes.widthPinCode,
          activeFillColor: Theme.of(context).colorScheme.background,
          inactiveFillColor: Theme.of(context).colorScheme.background),
      cursorColor: Theme.of(context).textTheme.labelMedium!.color,
    );
  }
}
