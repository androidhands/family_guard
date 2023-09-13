import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/features/emergency/presentation/controller/calls_log_provider.dart';
import 'package:family_guard/features/emergency/presentation/widgets/single_call_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallsLogScreen extends StatelessWidget {
  const CallsLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CallsLogProvider(),
        builder: (context, child) {
          return Consumer<CallsLogProvider>(
              builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.callsLog),
                withTransparent: false,
                withOutElevation: true,
                withMenu: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        provider.getCallsLogBuUser();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: ThemeColorLight.pinkColor,
                      ))
                ],
                popOnPressed: () {
                  NavigationService.goBack();
                },
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: provider.isLoading
                  ? Center(
                      child: CustomLoadingIndicators.defaultLoading(),
                    )
                  : ListView(
                      children: provider.phoneCalls
                          .map((e) => SingleCallLogWidget(
                                phoneCallEntity: e,
                                onPressed: () {
                                  provider.navigateToCallDetailsScreen(e);
                                },
                              ))
                          .toList(),
                    ),
            );
          });
        });
  }
}
