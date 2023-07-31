import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';

class RefreshTokenUsecase extends BaseUseCases<bool,String> {
  final BaseNotificationRepository baseNotificationRepository;

  RefreshTokenUsecase({required this.baseNotificationRepository});

  @override
  Future<Either<Failure, bool>> call(String params) {
    return baseNotificationRepository.refreshToken(params);
  }
}
