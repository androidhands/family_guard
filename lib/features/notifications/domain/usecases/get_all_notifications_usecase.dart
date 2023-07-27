import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_response_entity.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';


class GetAllNotificationsUsecase
    extends BaseUseCases<NotificationResponseEntity, GetAllNotificationParams> {
  final BaseNotificationRepository baseNotificationRepository;

  GetAllNotificationsUsecase({required this.baseNotificationRepository});

  @override
  Future<Either<Failure, NotificationResponseEntity>> call(
      GetAllNotificationParams parameters) {
    return baseNotificationRepository.getAllNotifications(parameters);
  }
}

class GetAllNotificationParams extends Equatable {
  final String keyWord;
  final int pageNumber;
  final int pageSize;
  final int status;
  final String accessToken;

  const GetAllNotificationParams(
      this.keyWord, this.pageNumber, this.pageSize, this.status,this.accessToken);

  @override
  List<Object?> get props => [keyWord, pageNumber, pageSize, status,accessToken];
}
