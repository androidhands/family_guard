import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../entities/sign_up_params.dart';
import '../entities/user_entity.dart';

abstract class BaseManualSignUpRepository {
 Future<Either<Failure,UserEntity>> signUpUserManually(SignUpParams signUpParams);
}