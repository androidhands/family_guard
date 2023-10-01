import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';



class TermsAndPrivacyPolicyScreen extends StatelessWidget {
  const TermsAndPrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            Center(
              child: CustomLoadingIndicators.defaultLoading(),
            );
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://uturnsoftware.com/terms-of-service'),
          headers: {'Authorization': 'Basic $basicAuth'},
          method: LoadRequestMethod.get);
    return Scaffold(
        appBar: CustomAppbar(
          title: tr(AppConstants.signUpTermsAgreementLink),
          withMenu: false,
          popOnPressed: () => NavigationService.goBack(),
          popIconsColor: ThemeColorLight.pinkColor,
        ),
        body: WebViewWidget(controller: controller));
  }
}
