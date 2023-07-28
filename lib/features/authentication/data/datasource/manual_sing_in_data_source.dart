import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_caller.dart';
import '../../../../core/network/api_endpoint.dart';
import '../../../../core/network/model/error_message.dart';
import '../../../../core/services/dependency_injection_service.dart';
import '../../domain/entities/sign_in_params.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class BaseManualSingInDataSource {
  Future<UserEntity> signInUserManually(SignInParams signInParams);
}

class ManualSingInDataSource implements BaseManualSingInDataSource {
  @override
  Future<UserEntity> signInUserManually(SignInParams signInParams) async {
    return await sl<ApiCaller>().requestPost(
      ApiEndPoint.manualSignInPath,
      (data) => UserModel.fromJson(data),
      body: <String, dynamic>{
        'api_password': ApiEndPoint.apiPassword,
        'mobile': signInParams.mobile,
        'password': signInParams.password
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
