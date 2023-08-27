import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_response_entity.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';

import 'package:family_guard/features/notifications/domain/usecases/get_all_notifications_usecase.dart';
import 'package:family_guard/features/notifications/domain/usecases/set_is_read_notification_usecase.dart';




class NotificationCountRepository implements BaseNotificationRepository {
  BaseNotificationDataSource baseNotificationDataSource;

  NotificationCountRepository({required this.baseNotificationDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotifications(
      GetAllNotificationParams params) async {
    try {
      return Right(
          await baseNotificationDataSource.getAllNotifications(params));
    } on ServerException catch (ex) {
      return Left(ServerFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, int>> getNotificationCount(String accessToken) async {
    try {
      return Right(
          await baseNotificationDataSource.getNotificationCount(accessToken));
    } on ServerException catch (ex) {
      return Left(ServerFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, bool>> setIsReadNotification(
      SetReadNotificationsParam parameters) async {
    try {
      return Right(
          await baseNotificationDataSource.setIsReadNotification(parameters));
    } on ServerException catch (ex) {
      return Left(ServerFailure(code: ex.code, message: ex.message));
    }
  }
  
  @override
  Future<Either<Failure, bool>> refreshToken(String token) async{
    try {
      return Right(
          await baseNotificationDataSource.refreshToken(token));
    } on ServerException catch (ex) {
      return Left(ServerFailure(code: ex.code, message: ex.message));
    }
  }
}
