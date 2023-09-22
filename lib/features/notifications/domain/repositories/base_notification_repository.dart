import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';

import '../usecases/set_is_read_notification_usecase.dart';

abstract class BaseNotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getAllNotifications(
      GetAllNotificationParams params);

  Future<Either<Failure, int>> getNotificationCount(String accessToken);

  Future<Either<Failure, bool>> setIsReadNotification(
      SetReadNotificationsParam parameters);

  Future<Either<Failure, bool>> refreshToken(String token);
}
