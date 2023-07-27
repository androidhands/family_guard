import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';

import '../utils/enums.dart';

// ignore: must_be_immutable
class CustomDatePickerDialog extends StatefulWidget {
  bool navigateBetweenDate = false;
  Function(DateTime) onPressed;
  Function(DateTime) onNextPressed;
  Function(DateTime) onPreviousePressed;
  //To Set the incremental and decremental action of next and previous buttons
  DatePickerOptions datePickerOptions;

  CustomDatePickerDialog(
      {Key? key,
      required this.navigateBetweenDate,
      required this.onPressed,
      required this.onNextPressed,
      required this.onPreviousePressed,
      required this.datePickerOptions})
      : super(key: key);

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.datePickerHight,
      margin: EdgeInsets.only(
        top: AppSizes.datePickerMariginH,
        bottom: AppSizes.datePickerMariginH,
        left: AppSizes.datePickerMariginW,
        right: AppSizes.datePickerMariginW,
      ),
      padding: EdgeInsets.only(
        top: AppSizes.pH1,
        bottom: AppSizes.pH1,
        left: AppSizes.pW1,
        right: AppSizes.pW1,
      ),
      decoration: BoxDecoration(
          color: ThemeColorLight.pinkColor,
          borderRadius: BorderRadius.circular(AppSizes.br25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.navigateBetweenDate)
            Expanded(
              flex: 1,
              child: InkWell(
          
                  onTap: () {
                    late DateTime newDate;
                    if (widget.datePickerOptions == DatePickerOptions.DAY) {
                      newDate = DateTime(
                          dateTime.year, dateTime.month, dateTime.day - 1);
                    } else if (widget.datePickerOptions ==
                        DatePickerOptions.MONTH) {
                      newDate = DateTime(
                          dateTime.year, dateTime.month - 1, dateTime.day);
                    } else if (widget.datePickerOptions ==
                        DatePickerOptions.YEAR) {
                      newDate = DateTime(
                          dateTime.year - 1, dateTime.month, dateTime.day);
                    }
                    setState(() {
                      dateTime = newDate;
                    });
                    widget.onPreviousePressed(newDate);
                  },
                  child:
                      CustomSvgImage.icons(path: AppAssets.previousButtonSvg)),
            ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: dateTime,
                  firstDate: DateTime(1930),
                  lastDate: DateTime(2050),
                  builder: (context, child) {
                    return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: ThemeColorLight.pinkColor, // <-- SEE HERE
                            onPrimary: ThemeColorLight.pinkColor, // <-- SEE HERE
                            onSurface:
                                ThemeColorLight.pinkColor, // <-- SEE HERE
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: ThemeColorLight
                                  .pinkColor, // button text color
                            ),
                          ),
                        ),
                        child: child!);
                  },
                ).then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        dateTime = value;
                        widget.onPressed(dateTime);
                      });
                    } 
                  },
                );
              },
              child: CustomText(
                widget.datePickerOptions == DatePickerOptions.DAY
                    ? DateParser().dateFormatterWithoutTime(dateTime)
                    : widget.datePickerOptions == DatePickerOptions.MONTH
                        ? DateParser().monthFormatter(dateTime)
                        : DateParser().yearFormatter(dateTime),
                textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: ThemeColorLight.whiteColor, fontSize: AppSizes.h6),
              ),
            ),
          ),
          if (widget.navigateBetweenDate)
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    late DateTime newDate;
                    if (widget.datePickerOptions == DatePickerOptions.DAY) {
                      newDate = DateTime(
                          dateTime.year, dateTime.month, dateTime.day + 1);
                    } else if (widget.datePickerOptions ==
                        DatePickerOptions.MONTH) {
                      newDate = DateTime(
                          dateTime.year, dateTime.month + 1, dateTime.day);
                    } else if (widget.datePickerOptions ==
                        DatePickerOptions.YEAR) {
                      newDate = DateTime(
                          dateTime.year + 1, dateTime.month, dateTime.day);
                    }
                    setState(() {
                      dateTime = newDate;
                    });
                    widget.onNextPressed(newDate);
                  },
                  child: CustomSvgImage.icons(path: AppAssets.nextButtonSvg)),
            ),
        ],
      ),
    );
  }
}
