import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/emergency/presentation/controller/emergency_calls_provider.dart';
import 'package:family_guard/features/emergency/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyCallScreen extends StatelessWidget {
  const EmergencyCallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EmergencyCallsProvider(),
        builder: (context, child) {
          return Consumer<EmergencyCallsProvider>(
              builder: (context, provider, child) {
            return Scaffold(
                appBar: CustomAppbar(
                  title: tr(AppConstants.emergencyCalls),
                  withTransparent: false,
                  withOutElevation: true,
                  withMenu: true,
                  actions: const [SizedBox()],
                  popOnPressed: () {
                    NavigationService.goBack();
                  },
                  popIconsColor: ThemeColorLight.pinkColor,
                ),
                body: Padding(
                  padding: EdgeInsets.all(AppSizes.pW5),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: provider.isLoadingMembers
                          ? Center(
                              child: CustomLoadingIndicators.defaultLoading(),
                            )
                          : provider.myMembers.isEmpty
                              ? Center(
                                  child: CustomText(
                                      'You have not any members to request help from them',
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color:
                                                  ThemeColorLight.pinkColor)))
                              : Column(
                                  children: List.generate(
                                      EmergencyTypes.values.length,
                                      (index) => CustomEmergencyTypeWidget(
                                            type: EmergencyTypes.values[index],
                                            onPresses: () {
                                              provider.setSelectedEmergencyType(
                                                  EmergencyTypes.values[index],
                                                  context);
                                            },
                                            isLoading: provider.isLoading &&
                                                EmergencyTypes.values[index] ==
                                                    provider
                                                        .selectedEmergencyTypes,
                                          ))),
                    ),
                  ),
                ));
          });
        });
  }
}

class CustomEmergencyTypeWidget extends StatelessWidget {
  final EmergencyTypes type;
  final Function onPresses;
  final bool isLoading;
  const CustomEmergencyTypeWidget(
      {super.key,
      required this.type,
      required this.onPresses,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPresses.call();
      },
      child: Container(
          margin: EdgeInsets.all(AppSizes.pW1),
          padding: EdgeInsets.all(AppSizes.pW1),
          height: AppSizes.pH10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColorLight.whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: CustomText(tr(type.name),
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(
                            color: ThemeColorLight.pinkColor,
                            fontSize: AppSizes.h4,
                            fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  flex: 1,
                  child: isLoading
                      ? CustomLoadingIndicators.defaultLoading()
                      : CustomElevatedButton(
                          text: tr(AppConstants.requestHelp),
                          onPressed: () {
                            onPresses.call();
                          },
                        ))
              // CustomSvgImage.square(path: AppAssets.emergencyCallSvg),
            ],
          )),
    );
  }
}
