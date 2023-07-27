import 'dart:convert';

import 'package:family_guard/features/authentication/data/models/user_model.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/local_data/shared_preferences_services.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/entities/sign_up_params.dart';

abstract class BaseManualSignUpDataSource {
  Future<UserEntity> signUpUserManually(SignUpParams signUpParams);
  
}

class ManualSignUpDataSource implements BaseManualSignUpDataSource {
  @override
  Future<UserEntity> signUpUserManually(SignUpParams signUpParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.manualSignUpPath,
      (data) => UserModel.fromJson(data),
      body: signUpParams.toJson(),
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  
}
