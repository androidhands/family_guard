import 'dart:io';

import 'package:family_guard/features/notifications/data/models/notification_model.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/controllers/main_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';

import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../domain/usecases/set_is_read_notification_usecase.dart';

abstract class BaseNotificationDataSource {
  Future<int> getNotificationCount(String accessToken);

  Future<List<NotificationEntity>> getAllNotifications(
      GetAllNotificationParams params);

  Future<bool> setIsReadNotification(SetReadNotificationsParam parameters);
  Future<bool> refreshToken(String token);
}

class NotificationDataSource extends BaseNotificationDataSource {
  @override
  Future<List<NotificationEntity>> getAllNotifications(
      GetAllNotificationParams params) async {
    return await sl<ApiCaller>().requestPost(
      '${ApiEndPoint.getAllNotifications}?api_password=${ApiEndPoint.apiPassword}&page=${params.pageNumber}',
      (data) {
        return List<NotificationEntity>.from(
            data['data'].map((e) => NotificationModel.fromJson(e))).toList();
      },
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
  Future<int> getNotificationCount(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      '${ApiEndPoint.getNotificationsUnReadCount}?api_password=${ApiEndPoint.apiPassword}',
      (data) {
        return data;
      },
      token:  accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<bool> refreshToken(String token) async {
    UserEntity? userEntity =
        await Provider.of<MainProvider>(Get.context!, listen: false)
            .getCachedUserCredentials();
    if (userEntity == null) return false;
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addFCMTokenPath,
      (data) => true,
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'fcmtoken': {
          'mobile': userEntity.mobile,
          'token': token,
          'platform': Platform.operatingSystem
        }
      },
      token: userEntity.apiToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
