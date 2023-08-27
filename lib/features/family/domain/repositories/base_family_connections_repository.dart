import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/family/domain/entities/request_connection_params.dart';

import '../../../authentication/domain/entities/user_entity.dart';
import '../usecases/send_new_member_request_usecase.dart';

abstract class BaseFamilyConnectionsRepository {
  Future<Either<Failure,Stream<List<UserEntity>>>> getFamilyConnections(String accessToken);
  Future<Either<Failure, String>> addNewFamilyConnections(
      AddNewMemberParams addNewMemberParams);
  Future<Either<Failure, List<UserEntity>>> getSentConnectionRequest(String accessToken);
  Future<Either<Failure, List<UserEntity>>> getReceivedConnectionRequest(String accessToken);
   Future<Either<Failure,List<UserEntity>>> acceptConnectionRequest(RequestConnectionParams requestConnectionParams);
  Future<Either<Failure,List<UserEntity>>> cancelConnectionRequest(RequestConnectionParams requestConnectionParams);
}
