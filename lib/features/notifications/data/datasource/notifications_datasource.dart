import 'package:family_guard/features/notifications/data/models/notification_response_model.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_response_entity.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../domain/usecases/set_is_read_notification_usecase.dart';

abstract class BaseNotificationDataSource {
  Future<int> getNotificationCount();

  Future<NotificationResponseEntity> getAllNotifications(
      GetAllNotificationParams params);

  Future<bool> setIsReadNotification(SetReadNotificationsParam parameters);
}

class NotificationDataSource extends BaseNotificationDataSource {
  @override
  Future<NotificationResponseEntity> getAllNotifications(
      GetAllNotificationParams params) async {
    return await sl<ApiCaller>().requestGet(
      '${ApiEndPoint.getAllNotifications}?Paging.PageNumber=${params.pageNumber}&Paging.PageSize=${params.pageSize}',
      builder: (data) {
        return NotificationResponseModel.fromJson(data);
      },
      tenantId: defaultAppTenant,
      token: params.accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<bool> setIsReadNotification(
      SetReadNotificationsParam parameters) async {
    /* var res = await Provider.of<MainProvider>(Get.context!, listen: false)
        .getAuthenticationResultModel();
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getIsReadNotifications,
      (data) {
        return data;
      },
      body: parameters.notificationsList,
      token: res?.accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    ); */
    return false;
  }

  @override
  Future<int> getNotificationCount() async {
    /*   var res = await Provider.of<MainProvider>(Get.context!, listen: false)
        .getAuthenticationResultModel();
    return await sl<ApiCaller>().requestGet(
      ApiEndPoint.getUnreadCount,
      builder: (data) {
        return data;
      },
      token: res?.accessToken,
      tenantId: defaultAppTenant,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    ); */

    return 0;
  }
}
