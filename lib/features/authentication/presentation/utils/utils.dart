import 'package:family_guard/core/utils/app_assets.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';


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

 bool isValidNumber(PhoneNumber phoneNumber) {
    Country country = getCountry(phoneNumber.completeNumber);
    if (phoneNumber.number.length < country.minLength) {
      return false;
    }

    if (phoneNumber.number.length > country.maxLength) {
      return false;
    }
    return true;
  }

   Country getCountry(String phoneNumber) {
    final validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validPhoneNumber.hasMatch(phoneNumber)) {
      throw InvalidCharactersException();
    }

    if (phoneNumber.startsWith('+')) {
      return countries.firstWhere((country) => phoneNumber
          .substring(1)
          .startsWith(country.dialCode + country.regionCode));
    }
    return countries.firstWhere((country) =>
        phoneNumber.startsWith(country.dialCode + country.regionCode));
  }