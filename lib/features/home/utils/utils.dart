import 'package:family_guard/core/utils/app_assets.dart';

import '../../../core/global/localization/app_localization.dart';
import '../../../core/integrated_library/bottom_navigation_bar/tab_item.dart';
import '../../../core/utils/app_constants.dart';

List<TabItem> get getBottomNavigationBarIList => [
      TabItem(iconPath: AppAssets.mapSvg, title: tr(AppConstants.map)),
      TabItem(iconPath: AppAssets.familySvg, title: tr(AppConstants.family)),
    ];

enum BranchStatus {
  online,
  offline,
}
