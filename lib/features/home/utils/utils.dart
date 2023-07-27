import 'package:family_guard/core/utils/app_assets.dart';

import '../../../core/global/localization/app_localization.dart';
import '../../../core/integrated_library/bottom_navigation_bar/tab_item.dart';
import '../../../core/utils/app_constants.dart';


List<TabItem> get getBottomNavigationBarIList => [
      TabItem(iconPath: AppAssets.profileSvg, title: tr(AppConstants.profile)),
      TabItem(iconPath: AppAssets.home, title: tr(AppConstants.appointments)),
      TabItem(iconPath: AppAssets.moreSvg, title: tr(AppConstants.more)),
    ];

enum BranchStatus {
  online,
  offline,
}

