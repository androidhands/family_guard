/* import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DynamicLinkService {
  DynamicLinkService._();

  static final instance = DynamicLinkService._();

  static bool isDynamicLinkHandled = false;

  static const String domainUrl = 'https://family_guardbusiness.page.link';

  Future<Uri> createDynamicLink({
    String urlParams = '',
    SocialMetaTagParameters? socialMetaTagParameters,
  }) async {
    try {
      final DynamicLinkParameters parameters = DynamicLinkParameters(
          uriPrefix: domainUrl,
          link: Uri.parse('$domainUrl/$urlParams'),
          androidParameters: const AndroidParameters(
            packageName: 'com.adwat.family_guardbusiness',
            minimumVersion: 1,
          ),
          iosParameters: const IOSParameters(
            bundleId: 'com.adwat.family_guardbusiness',
            appStoreId: '',
            minimumVersion: '1.0.0',
          ),
          socialMetaTagParameters: socialMetaTagParameters);
      final ShortDynamicLink shortDynamicLink =
      await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      final Uri dynamicUrl = shortDynamicLink.shortUrl;
      return dynamicUrl;
    } catch (ex) {
      log('Error while generating dynamic links');
      log(ex.toString());
      return Uri();
    }
  }

  Future<void> retrieveDynamicLink() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;
      if (deepLink != null) {
        log("Deeplink received $deepLink");
        processReceivedDeepLink(
            deepLink.pathSegments[0], deepLink.queryParameters);
      }

      FirebaseDynamicLinks.instance.onLink
          .listen((PendingDynamicLinkData? dynamicLink) async {
        log("Deeplink onLink ==> ${dynamicLink!.link}");
        processReceivedDeepLink(
            dynamicLink.link.pathSegments[0], dynamicLink.link.queryParameters);
      });
      isDynamicLinkHandled = true;
    } catch (e) {
      log("DLE = $e");
    }
  }

  shareDynamicLink({required String link, String subject = ''}) {
    Share.share(link, subject: subject);
  }

  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchURL(url);
    } else {
      DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(AppConstants.somethingWentWrongOrInvalidLink),
        buttonText: tr(AppConstants.ok),
      );
      throw 'Could not launch $url';
    }
  }

  processReceivedDeepLink(String path, Map<String, String> queryParams) {
    log('pathSegments.toString()');
    log(path.toString());
    queryParams = {
      for (var key in queryParams.keys)
        key: Uri.decodeComponent(Uri.encodeQueryComponent(queryParams[key]!)),
    };
    log('params.toString()');
    log(queryParams.toString());
    log("Path");
    log(path);
    switch (path) {
      case '':
        {
          // handleSetPasswordEmailDL(queryParams);
        }
        break;
    }
  }
}
 */