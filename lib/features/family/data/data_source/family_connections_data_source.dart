import 'dart:async';

import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/domain/entities/request_connection_params.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../domain/usecases/send_new_member_request_usecase.dart';

abstract class BaseFamilyConnectionsDataSource {
  Future<List<UserEntity>> getFamilyConnections(String accessToken);
  Future<String> addNewFamilyConnections(AddNewMemberParams addNewMemberParams);
  Future<List<UserEntity>> getSentConnectionRequest(String accessToken);
  Future<List<UserEntity>> getReceivedConnectionRequest(String accessToken);
  Future<List<UserEntity>> acceptConnectionRequest(
      RequestConnectionParams requestConnectionParams);
  Future<List<UserEntity>> cancelConnectionRequest(
      RequestConnectionParams requestConnectionParams);
}

class FamilyConnectionsDataSource implements BaseFamilyConnectionsDataSource {
  @override
  Future<List<UserEntity>> getFamilyConnections(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getFamilyConnectionsPath,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<String> addNewFamilyConnections(
      AddNewMemberParams addNewMemberParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addNewFamilyConnectionsPath,
      (data) => data,
      body: addNewMemberParams.toMap(),
      token: addNewMemberParams.accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> getReceivedConnectionRequest(
      String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getReceivedMembersRequest,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> getSentConnectionRequest(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getSentMembersRequests,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> acceptConnectionRequest(
      RequestConnectionParams requestConnectionParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.acceptConnectionRequest,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      body: requestConnectionParams.toMap(),
      token: requestConnectionParams.accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> cancelConnectionRequest(
      RequestConnectionParams requestConnectionParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.cancelConnectionRequest,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      body: requestConnectionParams.toMap(),
      token: requestConnectionParams.accessToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
