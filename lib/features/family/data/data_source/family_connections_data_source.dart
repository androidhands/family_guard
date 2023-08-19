import 'dart:convert';
import 'dart:developer';

import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../domain/usecases/send_new_member_request_usecase.dart';

abstract class BaseFamilyConnectionsDataSource {
  Future<List<UserEntity>> getFamilyConnections();
  Future<String> addNewFamilyConnections(AddNewMemberParams addNewMemberParams);
  Future<List<UserEntity>> getSentConnectionRequest();
  Future<List<UserEntity>> getReceivedConnectionRequest();
}

class FamilyConnectionsDataSource implements BaseFamilyConnectionsDataSource {
  @override
  Future<List<UserEntity>> getFamilyConnections() async {
    UserEntity user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getFamilyConnectionsPath,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: user.apiToken,
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
    UserEntity user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addNewFamilyConnectionsPath,
      (data) => data,
      body: addNewMemberParams.toMap(),
      token: user.apiToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> getReceivedConnectionRequest() async {
    UserEntity user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getReceivedMembersRequest,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: user.apiToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<List<UserEntity>> getSentConnectionRequest() async {
    UserEntity user =
        Provider.of<MainProvider>(Get.context!, listen: false).userCredentials!;

    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getSentMembersRequests,
      (data) => List<UserEntity>.from(data.map((e) => UserModel.fromJson(e)))
          .toList(),
      token: user.apiToken,
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
