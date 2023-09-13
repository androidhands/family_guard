import 'dart:convert';
import 'dart:developer';

import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/network/model/error_message.dart';
import 'package:family_guard/core/services/background_dependency_injection.dart';
import 'package:family_guard/features/emergency/data/models/add_new_caller_id_model.dart';
import 'package:family_guard/features/emergency/data/models/phone_call_model.dart';
import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/usecases/get_call_log_by_sid_usecase.dart';
import 'package:family_guard/features/emergency/domain/usecases/make_emergency_call_usecase.dart';

abstract class BaseEmergencyCallsDatasource {
  Future<bool> checkVerifiedCallerId(String accessToken);
  Future<AddNewCallerIdEntity> addNewCallerId(String accessToken);
  Future<PhoneCallEntity> makeEmergencyCall(
      EmergencyCallParams emergencyCallParams);
  Future<List<PhoneCallEntity>> getCallsLog(String accessToken);
  Future<PhoneCallEntity> getCallLogBySid(CallLogParams callLogParams);
}

class EmergencyCallsDatasource implements BaseEmergencyCallsDatasource {
  @override
  Future<bool> checkVerifiedCallerId(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.checkVerifiedCallerIdPath,
      (data) => data,
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }

  @override
  Future<AddNewCallerIdEntity> addNewCallerId(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.addnewCallerIdPath,
      (data) => AddNewCallerIdModel.fromJson(data),
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }

  @override
  Future<PhoneCallEntity> makeEmergencyCall(emergencyCallParams) async {
    log('Emergency Params ${jsonEncode(emergencyCallParams.toMap())}');
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.makeEmergencyCallPath,
      (data) => PhoneCallModel.fromJson(data),
      token: emergencyCallParams.accessToken,
      body: emergencyCallParams.toMap(),
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }

  @override
  Future<List<PhoneCallEntity>> getCallsLog(String accessToken) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getCallsLogPath,
      (data) => List<PhoneCallEntity>.from(
          data.map((e) => PhoneCallModel.fromJson(e))).toList(),
      token: accessToken,
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }

  @override
  Future<PhoneCallEntity> getCallLogBySid(CallLogParams callLogParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.getCallLogBySidPath,
      (data) => PhoneCallModel.fromJson(data),
      token: callLogParams.accessToken,
      body: callLogParams.toMap(),
      onFailure: (ErrorMessage failureData) {
        failureData.code == "23000"
            ? throw ServerException(
                message: 'Douplicated Entry',
                code: failureData.code,
              )
            : throw ServerException(
                message: failureData.message,
                code: failureData.code,
              );
      },
    );
  }
}
