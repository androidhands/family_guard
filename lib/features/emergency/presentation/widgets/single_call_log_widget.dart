import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_gradient_text.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/emergency/data/models/time_zone_model.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:flutter/material.dart';

class SingleCallLogWidget extends StatelessWidget {
  final PhoneCallEntity phoneCallEntity;
  final Function onPressed;

  const SingleCallLogWidget(
      {Key? key, required this.phoneCallEntity, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        margin: EdgeInsets.all(AppSizes.pW2),
        padding: EdgeInsets.all(AppSizes.pW2),
        height: AppSizes.mapAddressHight2,
        decoration: BoxDecoration(
            color: ThemeColorLight.whiteColor,
            borderRadius: BorderRadius.circular(AppSizes.br6),
            border: Border.all(width: 0.5, color: ThemeColorLight.pinkColor)),
        child: Row(children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText('Emergency Case: ${phoneCallEntity.emergencyType}',
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ThemeColorLight.pinkColor,
                      fontSize: AppSizes.h4,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomGradientText(
                  text:
                      'Date Created: ${phoneCallEntity.dateCreated == null ? 'Click to show Details' : phoneCallEntity.dateCreated is String ? DateParser().dateFormatterOnlyDateTime(phoneCallEntity.dateCreated!) : DateParser().dateFormatterOnlyDateTime(TimeZoneModel.fromJson(phoneCallEntity.dateCreated!).date)}'),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomText('Street: ${phoneCallEntity.street}',
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ThemeColorLight.pinkColor,
                      fontSize: AppSizes.h6,
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomText('City: ${phoneCallEntity.city}',
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ThemeColorLight.pinkColor,
                      fontSize: AppSizes.h6,
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomText('State: ${phoneCallEntity.state}',
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ThemeColorLight.pinkColor,
                      fontSize: AppSizes.h6,
                      fontWeight: FontWeight.normal)),
              SizedBox(
                height: AppSizes.pH1,
              ),
              CustomText('Country: ${phoneCallEntity.country}',
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ThemeColorLight.pinkColor,
                      fontSize: AppSizes.h6,
                      fontWeight: FontWeight.normal)),
            ],
          )),
          CustomSvgImage.square(path: AppAssets.pendingSvg)
        ]),
      ),
    );
  }
}
