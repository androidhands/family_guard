import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../entities/user_entity.dart';

abstract class BaseUserCredentialsRepository {
 Future<Either<Failure,bool>> saveUserCredentials(UserEntity userEntity);
  Future<Either<Failure,UserEntity?>> getCachedUserCredentials();
}