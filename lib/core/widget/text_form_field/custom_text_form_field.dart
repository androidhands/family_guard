import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_fonts.dart';
import 'package:family_guard/core/utils/utils.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../../utils/app_sizes.dart';
import '../../utils/enums.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.keyTextField,
      this.readonly = false,
      this.obscureText = false,
      this.keyboardType,
      this.textInputAction,
      this.textDirection,
      this.onChanged,
      this.enabled,
      this.onFieldSubmitted,
      this.labelText,
      this.maxLines = 1,
      this.minLines = 1,
      this.maxLength,
      this.inputFormatters,
      this.prefixOnPressed,
      this.suffixOnPressed,
      this.validator,
      this.colorSuffixIcon,
      this.fillColor,
      this.initialValue,
      this.onFocusChange,
      this.prefixIconTextFieldState = IconTextFieldState.EMPTY,
      this.suffixIconTextFieldState = IconTextFieldState.EMPTY,
      this.usePrefixIconDefaultColor = true,
      this.suffixWidget})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final String? keyTextField;
  final bool readonly;
  final bool obscureText;
  final Color? colorSuffixIcon;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? suffixOnPressed;
  final void Function()? prefixOnPressed;
  final bool usePrefixIconDefaultColor;
  final Widget? suffixWidget;

  final String? Function(String?)? validator;
  final IconTextFieldState prefixIconTextFieldState;
  final IconTextFieldState suffixIconTextFieldState;
  final void Function(bool)? onFocusChange;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {});
        if (widget.onFocusChange != null) widget.onFocusChange!(focus);
      },
      child: TextFormField(
          initialValue: widget.initialValue,
          readOnly: widget.readonly,
          controller: widget.controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: (value) {
            setState(() {
              hasError = widget.validator!(value) != null;
            });
            return widget.validator!(value);
          },
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: AppSizes.h5,
              fontWeight: AppFonts.medium,
              color: ThemeColorLight.green),
          textDirection: widget.textDirection,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          focusNode: focusNode,
          maxLength: widget.maxLength,
          cursorColor:
              Theme.of(context).inputDecorationTheme.border!.borderSide.color,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.obscureText,
          key: ValueKey(widget.keyTextField),
          decoration: (const InputDecoration())
              .applyDefaults(Theme.of(context).inputDecorationTheme)
              .copyWith(
                counterText: "",
                counterStyle: const TextStyle(
                  height: double.minPositive,
                ),
                fillColor: widget.fillColor ??
                    Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.pW5,
                  vertical: AppSizes.pH3,
                ),
                enabledBorder:
                    Theme.of(context).inputDecorationTheme.enabledBorder,
                border: Theme.of(context).inputDecorationTheme.border,
                errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
                hintText: widget.hintText ?? "",
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                labelText: widget.labelText,
                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                focusedErrorBorder:
                    Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                floatingLabelStyle: hasError
                    ? Theme.of(context)
                        .inputDecorationTheme
                        .errorStyle!
                        .copyWith(fontSize: AppSizes.h7)
                    : focusNode.hasFocus
                        ? Theme.of(context)
                            .inputDecorationTheme
                            .floatingLabelStyle!
                            .copyWith(fontSize: AppSizes.h7)
                        : Theme.of(context)
                            .inputDecorationTheme
                            .labelStyle!
                            .copyWith(fontSize: AppSizes.h7),
                suffixIcon:
                    widget.suffixIconTextFieldState != IconTextFieldState.EMPTY
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: AppSizes.pW2,
                            ),
                            child: IconButton(
                              icon: CustomSvgImage.icons(
                                path: iconTextFieldPath[
                                    widget.suffixIconTextFieldState]!,
                                // color: colorSuffixIcon ??
                                //     Theme.of(context).iconTheme.color,
                              ),
                              onPressed: widget.suffixOnPressed,
                            ),
                          )
                        : null,
                prefixIcon:
                    widget.prefixIconTextFieldState != IconTextFieldState.EMPTY
                        ? IconButton(
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: widget.prefixOnPressed,
                            icon: CustomSvgImage.icons(
                              path: iconTextFieldPath[
                                  widget.prefixIconTextFieldState]!,
                              color: widget.usePrefixIconDefaultColor
                                  ? Theme.of(context).iconTheme.color
                                  : null,
                            ),
                          )
                        : null,
                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                disabledBorder:
                    Theme.of(context).inputDecorationTheme.disabledBorder,
              )),
    );
  }
}
