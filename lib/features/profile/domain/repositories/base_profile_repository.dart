 import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';

import '../../../authentication/domain/entities/user_entity.dart';
import '../usecases/save_profile_image_usecase.dart';

abstract class BaseProfileRepository {
 Future<Either<Failure,UserEntity>> saveUserProfileImage(
      SaveProfileImageParams saveProfileImageParams);
}