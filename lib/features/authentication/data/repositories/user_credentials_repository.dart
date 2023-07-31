import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/data/datasource/base_users_credentials_data_source.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_credentials_repository.dart';

class UserCredentialsRepository implements BaseUserCredentialsRepository {
  final BaseUsersCredentialsDataSource baseUsersCredentialsDataSource;

  UserCredentialsRepository({required this.baseUsersCredentialsDataSource});

  @override
  Future<Either<Failure, UserEntity?>> getCachedUserCredentials() async {
    try {
      return Right(
          await baseUsersCredentialsDataSource.getCachedUserCredentials());
    } on CacheFailure catch (ex) {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserCredentials(
      UserEntity userEntity) async {
    try {
      return Right(
          await baseUsersCredentialsDataSource.saveUserCredentials(userEntity));
    } on CacheFailure catch (ex) {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Either<Failure, bool> checkCashUser() {
    try {
      return Right(baseUsersCredentialsDataSource.checkUserCredentials());
    } on CacheFailure catch (ex) {
      return Left(CacheFailure(code: ex.code, message: ex.message));
    }
  }
}
