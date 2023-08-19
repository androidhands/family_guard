import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/data/data_source/family_connections_data_source.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';
import 'package:family_guard/features/family/domain/usecases/send_new_member_request_usecase.dart';

class FamilyConnectionRepositoy implements BaseFamilyConnectionsRepository {
  final BaseFamilyConnectionsDataSource baseFamilyConnectionsDataSource;

  FamilyConnectionRepositoy({required this.baseFamilyConnectionsDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getFamilyConnections() async {
    try {
      return Right(
          await baseFamilyConnectionsDataSource.getFamilyConnections());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure,String>> addNewFamilyConnections(
      AddNewMemberParams addNewMemberParams) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .addNewFamilyConnections(addNewMemberParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
  
  @override
  Future<Either<Failure, List<UserEntity>>> getReceivedConnectionRequest()async {
     try {
      return Right(
          await baseFamilyConnectionsDataSource.getReceivedConnectionRequest());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
  
  @override
  Future<Either<Failure, List<UserEntity>>> getSentConnectionRequest() async{
   try {
      return Right(
          await baseFamilyConnectionsDataSource.getSentConnectionRequest());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
