import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';

class GetAllNotificationsUsecase
    extends BaseUseCases<List<NotificationEntity>, GetAllNotificationParams> {
  final BaseNotificationRepository baseNotificationRepository;

  GetAllNotificationsUsecase({required this.baseNotificationRepository});

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
      GetAllNotificationParams params) {
    return baseNotificationRepository.getAllNotifications(params);
  }
}

class GetAllNotificationParams extends Equatable {
  final int pageNumber;
  final int status;
  final String accessToken;

  const GetAllNotificationParams(
      this.pageNumber, this.status, this.accessToken);

  @override
  List<Object?> get props => [pageNumber, status, accessToken];
}
