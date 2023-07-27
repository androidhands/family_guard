import 'package:flutter/material.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

import 'package:family_guard/features/notifications/domain/usecases/set_is_read_notification_usecase.dart';





class NotificationProvider extends ChangeNotifier {
  var scrollController = ScrollController();
  int pageNumber = 0;
  bool isLoadingNotification = false;
  List<NotificationEntity> notificationsList = [];

  final SetIsReadNotificationUseCase setIsReadNotificationUseCase;
  NotificationProvider(this.setIsReadNotificationUseCase) {
    scrollController.addListener(pagination);

    getAllNotifications();
  }

  void getAllNotifications() async {
   /*  pageNumber++;
    isLoadingNotification = true;
    await checkIsNotificationsReadUser();
    var accessTokenR =
        await Provider.of<MainProvider>(Get.context!, listen: false)
            .getAuthenticationResultModel();
    String accessToken = accessTokenR!.accessToken;
    Either<Failure, NotificationResponseEntity> results =
        await sl<GetAllNotificationsUsecase>()(
            GetAllNotificationParams('', pageNumber, 10, 0, accessToken));
    results.fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(l.message),
        buttonText: tr(AppConstants.ok),
      );
    }, (r) {
      if (r.items.isEmpty) {
        pageNumber--;
      } else {
        notificationsList.addAll(r.items);
      }
    });

    isLoadingNotification = false;
    notifyListeners(); */
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getAllNotifications();
    }
  }

  Future<bool> checkIsNotificationsReadUser() async {

    List<int> list = [];
    for (NotificationEntity n in notificationsList) {
      list.add(n.id);
    }
    bool result = (await setIsReadNotificationUseCase(
            SetReadNotificationsParam(list,)))
        .fold((l) {
      return false;
    }, (r) {
      return r;
    });
    return result;
  }
}
