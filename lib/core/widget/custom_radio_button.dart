import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final bool isDisabled;
  final void Function(String)? onChanged;

  const CustomRadioButton(
      {Key? key,
      required this.items,
      this.selectedItem,
      this.onChanged,
      this.isDisabled = false})
      : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.items.length,
        (index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (widget.isDisabled)
                ? Radio(
                    value: widget.items[index],
                    groupValue: widget.selectedItem,
                    activeColor: Theme.of(context).disabledColor,
                    fillColor: MaterialStateProperty.resolveWith(
                        (state) => Theme.of(context).disabledColor),
                    onChanged: null,
                  )
                : Radio(
                    value: widget.items[index],
                    groupValue: widget.selectedItem,
                    onChanged: (String? value) {
                      if (widget.onChanged != null) widget.onChanged!(value!);
                    },
                  ),
            Expanded(
              child: InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: (widget.isDisabled)
                    ? () {}
                    : () {
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.items[index]);
                        }
                      },
                child: (widget.isDisabled)
                    ? CustomText.primaryBodyLarge(
                        widget.items[index],
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: AppSizes.h7,
                                ),
                      )
                    : CustomText.secondaryDisplaySmall(
                        widget.items[index],
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        // textStyle: Theme.of(context).textTheme.displaySmall!,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
