import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/datasource/manual_sign_up_data_source.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_up_params.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_up_repository.dart';

import '../../../../core/error/exceptions.dart';

class ManualSignUpReposiory implements BaseManualSignUpRepository {
  final BaseManualSignUpDataSource baseManualSignUpDataSource;

  ManualSignUpReposiory({required this.baseManualSignUpDataSource});
  @override
  Future<Either<Failure, UserEntity>> signUpUserManually(
      SignUpParams signUpParams) async {
    try {
      return Right(
          await baseManualSignUpDataSource.signUpUserManually(signUpParams));
    } on ServerException catch (ex) {
      return Left(ServerFailure(message: ex.message, code: ex.code));
    }
  }
}
