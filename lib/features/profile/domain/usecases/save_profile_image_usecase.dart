import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/profile/domain/repositories/base_profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class SaveProfileImageUsecase
    extends BaseUseCases<UserEntity, SaveProfileImageParams> {
  final BaseProfileRepository baseProfileRepository;

  SaveProfileImageUsecase({required this.baseProfileRepository});

  @override
  Future<Either<Failure, UserEntity>> call(SaveProfileImageParams params) {
    return baseProfileRepository.saveUserProfileImage(params);
  }
}

class SaveProfileImageParams extends Equatable {
  final String token;
  final XFile image;

  const SaveProfileImageParams({required this.token, required this.image});

  @override
  List<Object?> get props => [token, image];
}
