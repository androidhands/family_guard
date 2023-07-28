import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/datasource/manual_sing_in_data_source.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_in_params.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_in_repository.dart';

import '../../../../core/error/exceptions.dart';

class ManualSignInRepository implements BaseManualSignInRepository {
  final BaseManualSingInDataSource baseManualSingInDataSource;

  ManualSignInRepository({required this.baseManualSingInDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUpUserManually(
      SignInParams signInParams) async {
    try {
      return Right(
          await baseManualSingInDataSource.signInUserManually(signInParams));
    } on ServerException catch (ex) {
      return Left(ServerFailure(message: ex.message, code: ex.code));
    }
  }
}
