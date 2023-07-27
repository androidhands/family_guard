import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/n_usecases.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';

class GetNotificationCountUseCase extends NUseCases<int> {
  final BaseNotificationRepository baseNotificationCountRepository;

  GetNotificationCountUseCase({required this.baseNotificationCountRepository});

  @override
  Future<Either<Failure, int>> call() async {
    return await baseNotificationCountRepository.getNotificationCount();
  }
}
