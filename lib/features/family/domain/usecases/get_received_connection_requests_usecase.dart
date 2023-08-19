import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';

class GetReceivedConnectionRequestsUsecase
    extends BaseUseCasesNoParams<List<UserEntity>> {
  final BaseFamilyConnectionsRepository baseFamilyConnectionsRepository;

  GetReceivedConnectionRequestsUsecase(
      {required this.baseFamilyConnectionsRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call() {
    return baseFamilyConnectionsRepository.getReceivedConnectionRequest();
  }
}
