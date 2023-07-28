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
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 3,
        );
      },
      onCompleted: (String value) async {
        if (onDone != null) {
          await onDone!(value);
        }
      },
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
          fontSize: AppSizes.h5,
          fontWeight: FontWeight.w600,
          color: ThemeColorLight.whiteColor),
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(AppSizes.br12),
          activeColor: ThemeColorLight.pinkColor,
          inactiveColor: ThemeColorLight.pinkWhiteColor,
          borderWidth: 1,
          selectedFillColor: ThemeColorLight.pinkColor,
          selectedColor: ThemeColorLight.errorColor,
          fieldHeight: AppSizes.heightPinCode,
          fieldWidth: AppSizes.widthPinCode,
          activeFillColor: ThemeColorLight.pinkColor,
          inactiveFillColor: ThemeColorLight.pinkWhiteColor),
      cursorColor: ThemeColorLight.whiteColor,
    );
  }
}
