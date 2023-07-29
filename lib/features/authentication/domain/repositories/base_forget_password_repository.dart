import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import '../usecases/check_verification_code_usecase.dart';
import '../usecases/reset_password_usecase.dart';
import '../usecases/verify_user_phone_usecase.dart';

abstract class BaseForgetPasswordRepository {
  Future<Either<Failure, String>> verifyUserPhoneNumber(
      VerifyParams verifyParams);
  Future<Either<Failure, String>> checkVerificationCode(
      CheckCodeParams checkCodeParams);
  Future<Either<Failure, UserEntity>> resetPassword(
      ResetPasswordParam resetPasswordParam);
}
