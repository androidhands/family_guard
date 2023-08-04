import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'package:family_guard/core/utils/utils.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/presentation/components/notification_group_separator_widget.dart';
import 'package:family_guard/features/notifications/presentation/controller/notification_provider.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../../../core/global/localization/app_localization.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widget/custom_appbar.dart';

import '../components/custom_notification_component.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationProvider>(
      create: (context) => NotificationProvider(sl()),
      builder: (context, child) {
        return Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.notifications),
                withMenu: false,
               
                popOnPressed: () => NavigationService.goBack(),
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: Stack(
                children: [
                  GroupedListView<NotificationEntity, String>(
                    controller: provider.scrollController,
                    elements: provider.notificationsList,
                    groupBy: (element) => singleDayValueFormat
                        .format(dateFormat.parse(element.creationTime)),
                    groupSeparatorBuilder: (String groupByValue) =>
                        NotificationGroupSeparatorWidget(
                      text: singleDayValueFormat.format(DateTime.now()) ==
                              groupByValue
                          ? 'Today'
                          : singleDayValueFormat.format(DateTime.now()
                                      .subtract(const Duration(days: 1))) ==
                                  groupByValue
                              ? 'Yesterday'
                              : groupByValue,
                    ),
                    itemBuilder: (context, element) =>
                        CustomNotificationComponent(
                      notificationEntity: element,
                    ),
                    /*  itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), */
                    // optional
                    useStickyGroupSeparators: false,
                    // optional
                    floatingHeader: false,
                    // optional
                    order: GroupedListOrder.DESC, // optional
                  ),
                  if (provider.isLoadingNotification)
                    Align(
                      alignment: Alignment.center,
                      child: CustomLoadingIndicators.defaultLoading(),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
