import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import '../../domain/entities/sign_up_params.dart';

abstract class BaseManualSignUpDataSource {
  Future<UserEntity> signUpUserManually(SignUpParams signUpParams);
}

class ManualSignUpDataSource implements BaseManualSignUpDataSource {
  @override
  Future<UserEntity> signUpUserManually(SignUpParams signUpParams) {
    // TODO: implement signUpUserManually
    throw UnimplementedError();
  }
}
 