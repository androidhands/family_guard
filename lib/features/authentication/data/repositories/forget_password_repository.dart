import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/datasource/base_forget_password_data_source.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_forget_password_repository.dart';
import 'package:family_guard/features/authentication/domain/usecases/reset_password_usecase.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/check_verification_code_usecase.dart';
import '../../domain/usecases/verify_user_phone_usecase.dart';

class ForgetPasswordRepository implements BaseForgetPasswordRepository {
  final BaseForgetPasswordDataSource baseForgetPasswordDataSource;

  ForgetPasswordRepository({required this.baseForgetPasswordDataSource});

  @override
  Future<Either<Failure, String>> checkVerificationCode(
      CheckCodeParams checkCodeParams) async {
    try {
      return Right(await baseForgetPasswordDataSource
          .checkVerificationCode(checkCodeParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: '0'));
    }
  }

  @override
  Future<Either<Failure, String>> verifyUserPhoneNumber(
      VerifyParams verifyParams) async {
    try {
      return Right(await baseForgetPasswordDataSource
          .verifyUserPhoneNumber(verifyParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: '0'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> resetPassword(
      ResetPasswordParam resetPasswordParam) async {
    try {
      return Right(
          await baseForgetPasswordDataSource.resetPassword(resetPasswordParam));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: '0'));
    }
  }
}
