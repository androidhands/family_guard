import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_check_box.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/authentication/presentation/utils/enums.dart';

import '../../../../core/utils/app_fonts.dart';

class ChooseGenderComponent extends StatelessWidget {

  final void Function(Genders gender) onChanged;

  const ChooseGenderComponent({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
          width: AppSizes.bs1_0,
        ),
        borderRadius: BorderRadius.circular(AppSizes.br4),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(top: AppSizes.pH3, start: AppSizes.pH6, bottom: AppSizes.pH6),
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
            SizedBox(height: AppSizes.pW7,),
            Row(
              children: List.generate(
                  Genders.values.length,
                  (index) => Expanded(
                    child: CustomCheckBox(
                          onChanged: (value) => onChanged(Genders.values[index]),
                          child: CheckBoxDefaultText(text: tr(Genders.values[index].name.toUpperCase())),
                        ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
