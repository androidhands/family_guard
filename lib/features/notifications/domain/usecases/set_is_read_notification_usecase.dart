import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/usecases/usecases.dart';


import '../repositories/base_notification_repository.dart';

class SetIsReadNotificationUseCase
    extends BaseUseCases<bool, SetReadNotificationsParam> {
  final BaseNotificationRepository baseNotificationRepository;

  SetIsReadNotificationUseCase({required this.baseNotificationRepository});

  @override
  Future<Either<Failure, bool>> call(SetReadNotificationsParam parameters) {
    return baseNotificationRepository.setIsReadNotification(parameters);
  }
}

class SetReadNotificationsParam extends Equatable {
  final List<int> notificationsList;


  const SetReadNotificationsParam(this.notificationsList,);

  @override
  List<Object?> get props => [notificationsList];
}
