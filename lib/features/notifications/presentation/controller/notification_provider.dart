import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/services/dependency_injection_service.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/widget/dialog_service.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/presentation/screens/received_requests_screen.dart';
import 'package:family_guard/features/family/presentation/screens/sent_requests_screen.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

import 'package:family_guard/features/notifications/domain/usecases/set_is_read_notification_usecase.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  var scrollController = ScrollController();
  int pageNumber = 0;
  bool isLoadingNotification = false;
  UserEntity userEntity =
      Provider.of<MainProvider>(Get.context!).userCredentials!;
  List<NotificationEntity> notificationsList = [];

  final SetIsReadNotificationUseCase setIsReadNotificationUseCase;
  NotificationProvider(this.setIsReadNotificationUseCase) {
    scrollController.addListener(pagination);

    getAllNotifications();
  }

  void getAllNotifications() async {
    pageNumber++;
    isLoadingNotification = true;
    // await checkIsNotificationsReadUser();

    Either<Failure, List<NotificationEntity>> results =
        await sl<GetAllNotificationsUsecase>()(
            GetAllNotificationParams(pageNumber, 10, userEntity.apiToken!));
    results.fold((l) async {
      pageNumber--;
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: tr(l.message),
        buttonText: tr(AppConstants.ok),
      );
    }, (r) {
      if (r.isEmpty) {
        pageNumber--;
      } else {
        notificationsList.addAll(r);
      }
    });

    isLoadingNotification = false;
    notifyListeners();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getAllNotifications();
    }
  }

  markeNotificationsAsReed(NotificationEntity element) {
    log(const ReceivedRequestsScreen().toString());
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: element.data.routPath,
        isNamed: true);
    if (element.data.routPath.isNotEmpty) {}
  }

  /*  Future<bool> checkIsNotificationsReadUser() async {

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
  } */
}
