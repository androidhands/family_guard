import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../../../authentication/domain/entities/user_entity.dart';
import '../usecases/send_new_member_request_usecase.dart';

abstract class BaseFamilyConnectionsRepository {
  Future<Either<Failure, List<UserEntity>>> getFamilyConnections();
  Future<Either<Failure, String>> addNewFamilyConnections(
      AddNewMemberParams addNewMemberParams);
  Future<Either<Failure, List<UserEntity>>> getSentConnectionRequest();
  Future<Either<Failure, List<UserEntity>>> getReceivedConnectionRequest();
}
