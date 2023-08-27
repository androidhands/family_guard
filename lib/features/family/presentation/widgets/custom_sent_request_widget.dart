import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_chip_choice_widget.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_cashed_network_image.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/presentation/utils/members_utils.dart';
import 'package:flutter/material.dart';

class CustomSentRequestWidget extends StatelessWidget {
  final UserEntity userEntity;
  final RequestType requestType;
  final String authToken;
  final Function(UserEntity) onPressed;
  const CustomSentRequestWidget(
      {Key? key,
      required this.userEntity,
      required this.requestType,
      required this.authToken,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.pW2),
      padding: EdgeInsets.only(left: AppSizes.pW2, right: AppSizes.pW2),
      height: AppSizes.requestCardHeight,
      decoration: BoxDecoration(
          color: ThemeColorLight.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.br6),
          border: Border.all(width: 0.5, color: ThemeColorLight.pinkColor)),
      child: Row(
        children: [
          userEntity.imageUrl.isEmpty || userEntity.imageUrl == "No Data"
              ? CustomSvgImage(
                  path: AppAssets.profileMan,
                  width: AppSizes.profileImageWidth,
                  height: AppSizes.profileImageHight,
                )
              : CustomCashedNetworkImage.circle(
                  imageUrl: userEntity.imageUrl, size: 50, token: authToken),
          Padding(
            padding: EdgeInsets.only(left: AppSizes.pW5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(userEntity.userName,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: ThemeColorLight.pinkColor,
                                fontSize: AppSizes.h5)),
                    CustomChipChoiceWidget(
                      title: userEntity.memberEntity!.requestAccepted,
                      token: authToken,
                      isEnabled: false,
                      onSelected: (v) {
                        onPressed.call(userEntity);
                      },
                      prefixPath: userEntity.memberEntity!.accepted == 0
                          ? AppAssets.pendingSvg
                          : userEntity.memberEntity!.accepted == 1
                              ? AppAssets.requestAccepted
                              : AppAssets.requestCanceled,
                    )
                  ],
                ),
                CustomText(
                    requestType == RequestType.Sent
                        ? 'My ${userEntity.memberEntity!.memberRelation}'
                        : 'Adding you as his ${userEntity.memberEntity!.memberRelation}',
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                            color: ThemeColorLight.pinkColor,
                            fontSize: AppSizes.h6)),
                CustomText(userEntity.memberEntity!.isLocationTracked,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                            color: ThemeColorLight.pinkColor,
                            fontSize: AppSizes.h6)),
                CustomText(userEntity.memberEntity!.isEmergency,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                            color: ThemeColorLight.pinkColor,
                            fontSize: AppSizes.h6)),
                if (userEntity.memberEntity!.createdAt != null)
                  CustomText(
                      'Requested at : ${DateParser().dateFormatterOnlyDateTime(userEntity.memberEntity!.createdAt!).toString()}',
                      textStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                              color: ThemeColorLight.pinkColor,
                              fontSize: AppSizes.h6))
              ],
            ),
          )
        ],
      ),
    );
  }
}
