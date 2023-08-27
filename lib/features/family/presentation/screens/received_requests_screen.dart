import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/buttons/custom_elevated_button.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/custom_text.dart';
import 'package:family_guard/features/family/presentation/controllers/received_requests_provider.dart';
import 'package:family_guard/features/family/presentation/widgets/accept_request_bottom_modal_dialog.dart';
import 'package:family_guard/features/family/presentation/widgets/custom_sent_request_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ReceivedRequestsScreen extends StatelessWidget {
  const ReceivedRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ReceivedRequestsProvider(),
        builder: (context, child) {
          return Consumer<ReceivedRequestsProvider>(
              builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.receivedRequests),
                withTransparent: false,
                withOutElevation: true,
                withMenu: true,
                actions: const [SizedBox()],
                popOnPressed: () {
                  NavigationService.goBack();
                },
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: provider.isLoodingRequests
                  ? Center(
                      child: CustomLoadingIndicators.defaultLoading(),
                    )
                  : provider.receivedRequest!.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              tr(AppConstants.noReceivedRequestFound),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: AppSizes.h4,
                                      color: ThemeColorLight.pinkColor),
                            ),
                            SizedBox(
                              height: AppSizes.pH2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppSizes.pW10, right: AppSizes.pW10),
                              child: CustomElevatedButton(
                                onPressed: () =>
                                    provider.navigateToAddNewMemberRequest(),
                                text: tr(AppConstants.addMember),
                                isEnabled: true,
                              ),
                            ),
                          ],
                        ))
                      : ListView(
                          children: provider.receivedRequest!
                              .map((e) => CustomSentRequestWidget(
                                    userEntity: e,
                                    requestType: provider.requestType,
                                    authToken: provider.user.apiToken!,
                                    onPressed: (user) {
                                      showBarModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return AcceptRequestBottomModalDialog(
                                              userEntity: user,
                                              onAcceptRequest: (user) {
                                                provider
                                                    .acceptConnectionRequest(
                                                        user);
                                              },
                                              onCancelRequest: (user) {
                                                provider
                                                    .cancelConnectionRequest(
                                                        user);
                                              },
                                            );
                                          });
                                    },
                                  ))
                              .toList(),
                        ),
            );
          });
        });
  }
}
