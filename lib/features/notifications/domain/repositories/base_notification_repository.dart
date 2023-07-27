import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_response_entity.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';

import '../usecases/set_is_read_notification_usecase.dart';

abstract class BaseNotificationRepository {
  Future<Either<Failure, NotificationResponseEntity>> getAllNotifications(
      GetAllNotificationParams params);
      
  Future<Either<Failure, int>> getNotificationCount();

  Future<Either<Failure, bool>> setIsReadNotification(
      SetReadNotificationsParam parameters);
}
