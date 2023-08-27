import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/images/custom_png_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';

import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_gradient_text.dart';
import 'package:family_guard/core/widget/custom_network_image.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_caller.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomNotificationComponent extends StatelessWidget {
  final NotificationEntity notificationEntity;
  final Function onPressed;

  const CustomNotificationComponent(
      {Key? key, required this.notificationEntity, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserEntity user = Provider.of<MainProvider>(context).userCredentials!;
    return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        margin: EdgeInsets.only(top: AppSizes.pH3),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppSizes.notificationCardRadius),
            color: notificationEntity.seen == 1
                ? null
                : Theme.of(context).cardColor),
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
                            child: notificationEntity.data.imageUrl.isEmpty ||
                                    notificationEntity.data.imageUrl ==
                                        "No Data"
                                ? CustomPngImage.square(
                                    path: AppAssets.appLogo,
                                  )
                                : notificationEntity.data.imageUrl == "person"
                                    ? CustomSvgImage(
                                        path: AppAssets.profileMan,
                                        width: AppSizes.notificationIconSize,
                                        height: AppSizes.notificationIconSize,
                                      )
                                    : CustomNetworkImage.circle(
                                        imageUrl:
                                            '$attachmentBaseUrl${notificationEntity.data.imageUrl}',
                                        size: AppSizes.notificationIconSize,
                                        fit: BoxFit.cover,
                                        token: user.apiToken!,
                                      ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.primaryBodyLarge(
                                notificationEntity.data.title,
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
                                notificationEntity.data.data,
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
                        child: notificationEntity.readAt == null
                            ? CustomText.secondaryDisplaySmall(
                                DateParser().dateFormatterOnlyTime(
                                    notificationEntity.createdAt),
                              )
                            : CustomGradientText(
                                text: DateParser().dateFormatterOnlyTime(
                                    notificationEntity.createdAt

                                    /*  timeFormat
                        .format(dateFormat.parse(notificationEntity.creationTime), */
                                    ))),
                  ),
                ]),
            if (notificationEntity.seen == 1)
              Divider(
                thickness: AppSizes.dividerThickness,
              )
          ],
        ),
      ),
    );
  }
}
