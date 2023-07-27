import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_gradient_text.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

import '../../../../core/network/api_caller.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomNotificationComponent extends StatelessWidget {
  final NotificationEntity notificationEntity;

  const CustomNotificationComponent(
      {Key? key, required this.notificationEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO : MOSTAFA : 2021-09-09
    return Container(
      margin: EdgeInsets.only(top: AppSizes.pH3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.notificationCardRadius),
          color:
              notificationEntity.isReaded ? null : Theme.of(context).cardColor),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: AppSizes.pH7,
                        bottom: AppSizes.pH3,
                        top: AppSizes.pH3),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.all(AppSizes.pH3),
                        child: Card(
                          shape: const CircleBorder(),
                          elevation: AppSizes.e3,
                          shadowColor: Theme.of(context).disabledColor,
                          color: ThemeColorLight.offWhite,
                          child: CustomNetworkImage.circle(
                            imageUrl:
                                '$attachmentBaseUrl${notificationEntity.imageUrl}',
                            size: AppSizes.notificationIconSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.primaryBodyLarge(
                              notificationEntity.titleStr.localizedName,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: AppSizes.h6,
                                    fontWeight: AppFonts.regular,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                            CustomText.secondaryDisplaySmall(
                              notificationEntity.bodyStr.localizedName,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontSize: AppSizes.h7,
                                  ),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(
                          top: AppSizes.pH5, right: AppSizes.pH5),
                      child: notificationEntity.isReaded
                          ? CustomText.secondaryDisplaySmall(
                              DateParser().dateFormatterOnlyTime(
                                  notificationEntity.creationTime),
                            )
                          : CustomGradientText(
                              text: DateParser().dateFormatterOnlyTime(
                                  notificationEntity.creationTime

                                  /*  timeFormat
                      .format(dateFormat.parse(notificationEntity.creationTime), */
                                  ))),
                ),
              ]),
          if (notificationEntity.isReaded)
            Divider(
              thickness: AppSizes.dividerThickness,
            )
        ],
      ),
    );
  }
}
