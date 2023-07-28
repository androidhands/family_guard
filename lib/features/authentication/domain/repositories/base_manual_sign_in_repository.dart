import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../entities/sign_in_params.dart';
import '../entities/user_entity.dart';

abstract class BaseManualSignInRepository {
 Future<Either<Failure,UserEntity>> signUpUserManually(SignInParams signInParams);
}