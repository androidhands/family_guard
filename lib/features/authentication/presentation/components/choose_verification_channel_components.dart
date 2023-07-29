import 'package:family_guard/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_check_box.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';

import '../../../../core/utils/app_fonts.dart';

class ChooseVerificationChannelComponent extends StatelessWidget {
  final void Function(Channels channels) onChanged;
  final Channels? selectedChannel;

  const ChooseVerificationChannelComponent(
      {Key? key, required this.onChanged, required this.selectedChannel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              Theme.of(context).inputDecorationTheme.border!.borderSide.color,
          width: AppSizes.bs1_0,
        ),
        borderRadius: BorderRadius.circular(AppSizes.br4),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            top: AppSizes.pH3, start: AppSizes.pH6, bottom: AppSizes.pH6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.primaryBodyLarge(
              tr(AppConstants.selectGender),
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: AppSizes.h5, fontWeight: AppFonts.medium),
            ),
            SizedBox(
              height: AppSizes.pW7,
            ),
            Row(children: [
              Expanded(
                child: ListTile(
                  title: CheckBoxDefaultText(
                      text: tr(Channels.sms.name.toUpperCase())),
                  leading: Radio(
                    value: Channels.sms,
                    groupValue: selectedChannel,
                    activeColor: ThemeColorDark.pinkColor,
                    onChanged: (value) {
                      onChanged(Channels.sms);
                      /*  setState(() {
                                              _cTgValue = value as int;
                                              visitType = '';
                                            }); */
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: CheckBoxDefaultText(
                      text: tr(Channels.whatsapp.name.toUpperCase())),
                  leading: Radio(
                    value: Channels.whatsapp,
                    groupValue: selectedChannel,
                    activeColor: ThemeColorDark.pinkColor,
                    onChanged: (value) {
                      onChanged(Channels.whatsapp);
                      /*  setState(() {
                                              _cTgValue = value as int;
                                              visitType = '';
                                            }); */
                    },
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
