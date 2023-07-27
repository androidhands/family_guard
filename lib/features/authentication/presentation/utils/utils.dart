import 'package:get/get.dart';
import 'package:family_guard/core/utils/app_assets.dart';

import 'package:provider/provider.dart';

import 'enums.dart';

Map<SocialMediaOptions, String> socialMediaLogoPath = {
  SocialMediaOptions.google: AppAssets.googleIconSvg,
  SocialMediaOptions.apple: AppAssets.appleIconSvg,
};
Map<int, Function> socialMediaActionSignUp = {
/*   SocialMediaOptions.facebook.index: () async {
    await Provider.of<FacebookProvider>(Get.context!, listen: false)
        .signUpWithFacebook();
  }, */
/*   SocialMediaOptions.twitter.index: () async {
    await Provider.of<TwitterProvider>(Get.context!, listen: false)
        .signUpWithTwitter();
  },
  SocialMediaOptions.apple.index: () async {
    await Provider.of<AppleProvider>(Get.context!, listen: false)
        .signUpWithApple();
  }, */

 
 
};
Map<int, Function> socialMediaActionSignIn = {
  /*  SocialMediaOptions.facebook.index: () async {
    await Provider.of<FacebookProvider>(Get.context!, listen: false)
        .signInWithFacebook();
  }, */
  /*  SocialMediaOptions.twitter.index: () async {
    await Provider.of<TwitterProvider>(Get.context!, listen: false)
        .signInWithTwitter();
  },
  SocialMediaOptions.apple.index: () async {
    await Provider.of<AppleProvider>(Get.context!, listen: false)
        .signInWithApple();
  }, */

};
