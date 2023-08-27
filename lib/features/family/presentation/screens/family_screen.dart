import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/presentation/controllers/family_members_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_family_member_widget.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyMembersProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.only(
            bottom: AppSizes.twoLineSnackbarHight,
            top: AppSizes.singleVisitContainerH),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(AppSizes.pH1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText('My Family Members',
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ThemeColorLight.pinkColor,
                                        fontSize: AppSizes.h4,
                                        fontWeight: FontWeight.bold)),
                            InkWell(
                                onTap: () {
                                  provider.getFamilyMembers();
                                },
                                child: CustomSvgImage.icons(
                                    path: AppAssets.refresh))
                          ],
                        ),
                      ),
                      Expanded(
                        child: provider.isLoadingFamilyMembers
                            ? Center(
                                child: CustomLoadingIndicators.defaultLoading(),
                              )
                            : provider.members.isEmpty
                                ? Center(
                                    child: CustomText(
                                        tr(AppConstants.noMemberAdded),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                                color:
                                                    ThemeColorLight.pinkColor)),
                                  )
                                : ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: provider.members
                                        .map(
                                          (e) => CustomFamilyMemberWidget(
                                            memberEntity: e,
                                            userEnt: provider.user,
                                            onPressed: () {
                                              provider
                                                  .navigateToMemberDetailsScreen();
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(AppSizes.pH5),
                decoration: BoxDecoration(
                    color: ThemeColorLight.pinkColor,
                    borderRadius: BorderRadius.circular(AppSizes.br6),
                    border:
                        Border.all(width: 1, color: ThemeColorLight.pinkColor)),
                child: InkWell(
                  onTap: () {
                    provider.navigateToAddMemberScreen();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomText(tr(AppConstants.addMember),
                            textAlign: TextAlign.start,
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: ThemeColorLight.whiteColor,
                                    fontSize: AppSizes.h4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomSvgImage.square(
                          path: AppAssets.addMemberSvg,
                          color: ThemeColorLight.whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(AppSizes.pW1),
                padding: EdgeInsets.all(AppSizes.pH5),
                decoration: BoxDecoration(
                    color: ThemeColorLight.pinkColor,
                    borderRadius: BorderRadius.circular(AppSizes.br6),
                    border:
                        Border.all(width: 1, color: ThemeColorLight.pinkColor)),
                child: InkWell(
                  onTap: () {
                    provider.navigateToReceivedRequestsScreen();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomText(tr(AppConstants.receivedRequests),
                            textAlign: TextAlign.start,
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: ThemeColorLight.whiteColor,
                                    fontSize: AppSizes.h4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomSvgImage.square(
                          path: AppAssets.incomingRequestsSvg,
                          color: ThemeColorLight.whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(AppSizes.pW1),
                padding: EdgeInsets.all(AppSizes.pH5),
                decoration: BoxDecoration(
                    color: ThemeColorLight.pinkColor,
                    borderRadius: BorderRadius.circular(AppSizes.br6),
                    border:
                        Border.all(width: 1, color: ThemeColorLight.pinkColor)),
                child: InkWell(
                  onTap: () {
                    provider.navigateToSentRequestsScreen();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomText(tr(AppConstants.sentRequests),
                            textAlign: TextAlign.start,
                            textStyle: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: ThemeColorLight.whiteColor,
                                    fontSize: AppSizes.h4)),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomSvgImage.square(
                          path: AppAssets.myMemberSvg,
                          color: ThemeColorLight.whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
