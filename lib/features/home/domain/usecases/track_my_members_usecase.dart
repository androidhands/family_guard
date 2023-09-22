import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/home/domain/repository/base_tracking_repository.dart';

class TrackMyMembersUsecase extends BaseUseCases<List<UserEntity>, String> {
  final BaseTrackingRepository baseTrackingRepository;

  TrackMyMembersUsecase({required this.baseTrackingRepository});
  @override
  Future<Either<Failure, List<UserEntity>>> call(String params) {
    return baseTrackingRepository.trackMyMembers(params);
  }
}
