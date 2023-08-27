import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/data/data_source/family_connections_data_source.dart';
import 'package:family_guard/features/family/domain/entities/request_connection_params.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';
import 'package:family_guard/features/family/domain/usecases/send_new_member_request_usecase.dart';

class FamilyConnectionRepositoy implements BaseFamilyConnectionsRepository {
  final BaseFamilyConnectionsDataSource baseFamilyConnectionsDataSource;

  FamilyConnectionRepositoy({required this.baseFamilyConnectionsDataSource});

  @override
  Future<Either<Failure, Stream<List<UserEntity>>>> getFamilyConnections(
      String accessToken) async {
    try {
      var list = await baseFamilyConnectionsDataSource
          .getFamilyConnections(accessToken);
        var streamController =
          StreamController<List<UserEntity>>(sync: true);
  
       streamController.sink.add( list);
      return Right(streamController.stream.asBroadcastStream());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, String>> addNewFamilyConnections(
      AddNewMemberParams addNewMemberParams) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .addNewFamilyConnections(addNewMemberParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getReceivedConnectionRequest(
      String accessToken) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .getReceivedConnectionRequest(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getSentConnectionRequest(
      String accessToken) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .getSentConnectionRequest(accessToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> acceptConnectionRequest(
      RequestConnectionParams requestConnectionParams) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .acceptConnectionRequest(requestConnectionParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> cancelConnectionRequest(
      RequestConnectionParams requestConnectionParams) async {
    try {
      return Right(await baseFamilyConnectionsDataSource
          .cancelConnectionRequest(requestConnectionParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
