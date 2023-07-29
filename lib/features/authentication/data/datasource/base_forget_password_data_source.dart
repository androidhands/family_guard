import 'package:family_guard/features/authentication/data/models/user_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/check_verification_code_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/verify_user_phone_usecase.dart';

abstract class BaseForgetPasswordDataSource {
  Future<String> verifyUserPhoneNumber(VerifyParams verifyParams);
  Future<String> checkVerificationCode(CheckCodeParams checkCodeParams);
  Future<UserEntity> resetPassword(ResetPasswordParam resetPasswordParam);
}

class ForgetPasswordDataSource implements BaseForgetPasswordDataSource {
  @override
  Future<String> verifyUserPhoneNumber(VerifyParams verifyParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.verifyPhoneNumberPath,
      (data) => data,
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': verifyParams.phone,
        'channel': verifyParams.channel
      },
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<String> checkVerificationCode(CheckCodeParams checkCodeParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.checkVerificationCodePath,
      (data) => data,
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': checkCodeParams.phone,
        'code': checkCodeParams.code,
      },
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }

  @override
  Future<UserEntity> resetPassword(
      ResetPasswordParam resetPasswordParam) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.resetPasswordPath,
      (data) => UserModel.fromJson(data),
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': resetPasswordParam.mobile,
        'token': resetPasswordParam.token,
        'password': resetPasswordParam.password
      },
      onFailure: (ErrorMessage failureData) {
        throw ServerException(
          message: failureData.message,
          code: failureData.code,
        );
      },
    );
  }
}
