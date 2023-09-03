// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:share_plus/share_plus.dart';
import 'package:family_guard/core/utils/app_assets.dart';

import '../global/theme/theme_color/theme_color_light.dart';
import '../services/navigation_service.dart';
import '../widget/custom_text.dart';
import 'app_sizes.dart';
import 'enums.dart';

bool isTablet() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
  if (data.size.shortestSide < 550) {
    return false;
  } else {
    return true;
  }
}

Map<IconTextFieldState, String?> iconTextFieldPath = {
  IconTextFieldState.EMPTY: null,
  IconTextFieldState.EMAIL: AppAssets.emailSvg,
  IconTextFieldState.OBSCURE: AppAssets.eyeCloseSvg,
  IconTextFieldState.NOT_OBSCURE: AppAssets.eyeOpenSvg,
  IconTextFieldState.SEARCH: AppAssets.searchSvg,
  IconTextFieldState.FAILURE: AppAssets.failureSvg,
  IconTextFieldState.CLEAR: AppAssets.closeSquareSvg,
  IconTextFieldState.CALENDER: AppAssets.calendar,
  IconTextFieldState.CLOCK: AppAssets.clock,
  IconTextFieldState.LOCK: AppAssets.lockSvg,
  IconTextFieldState.FACEBOOK: AppAssets.facebookIconProfile,
  IconTextFieldState.INSTAGRAM: AppAssets.instagramIconProfile,
};

String refineImage(String? imageUrl) {
  bool isURl(String url) {
    return RegExp(
            r'^((?:.|\n)*?)((http:www\.|https:www\.|http:|https:)?[a-z0-9]+([\]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
        .hasMatch(url);
  }

  // bool isValid = isURl(imageUrl!);
  return imageUrl!;
}

preCachedSvgImage(String imageUrl) {
  return svg.cache.putIfAbsent(SvgAssetLoader(imageUrl).cacheKey(null),
      () => SvgAssetLoader(imageUrl).loadBytes(null));
}

Future<void> share(String text) async {
  await Share.share(text);
}

final singleDayValueFormat = DateFormat("dd, MMMM yyyy");
final dateFormat = DateFormat("yyyy-MM-dd");
final timeFormat = DateFormat("h:mm a");

void showCustromDropDwonDialog(
    List<String> items, Function(String) onSelected, String title) {
  Get.defaultDialog(
    title: title, //tr(AppConstants.selectAccountType),
    content: SizedBox(
      height: 300,
      width: 200,
      child: ListView(
          children: items
              .map(
                (e) => GestureDetector(
                    onTap: () {
                      onSelected(e);
                      NavigationService.goBack();
                    },
                    child: CustomTitleCard(title: e)),
              )
              .toList()),
    ),
    /*   onCancel: () {
          NavigationService.goBack();
        } */
  );
}

class CustomTitleCard extends StatelessWidget {
  final String? title;
  const CustomTitleCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(title ?? '',
            textStyle: Theme.of(Get.context!)
                .textTheme
                .labelMedium!
                .copyWith(color: ThemeColorLight.pinkColor)),
        Divider(
          thickness: AppSizes.dividerThickness,
        )
      ],
    );
  }
}

Future<bool> handleLocationPermission() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.whileInUse) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: const Text(
          'Family Guard app works correctly if the location enabled allways in use, Select Permission->Location->Allow all the time'),
      action: SnackBarAction(
        label: 'Open App Settings',
        onPressed: () async {
          await openAppSettings();
        },
      ),
    ));
    return false;
  }
  return true;
}
