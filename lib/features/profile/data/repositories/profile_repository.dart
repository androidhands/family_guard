import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/exceptions.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/profile/data/datasource/profile_data_source.dart';
import 'package:family_guard/features/profile/domain/repositories/base_profile_repository.dart';
import 'package:family_guard/features/profile/domain/usecases/save_profile_image_usecase.dart';

class ProfileRepository implements BaseProfileRepository {
  final BaseProfileDataSource baseProfileDataSource;

  ProfileRepository({required this.baseProfileDataSource});

  @override
  Future<Either<Failure, UserEntity>> saveUserProfileImage(
      SaveProfileImageParams saveProfileImageParams) async {
    try {
      return Right(await baseProfileDataSource
          .saveUserProfileImage(saveProfileImageParams));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getUserAddress(String apiToken) async {
    try {
      return Right(await baseProfileDataSource.getUserAddress(apiToken));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
