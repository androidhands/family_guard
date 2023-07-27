import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_credentials_repository.dart';

class SaveUserCredentialsUsecase extends BaseUseCases<bool, UserEntity> {
  final BaseUserCredentialsRepository baseUserCredentialsRepository;

  SaveUserCredentialsUsecase({required this.baseUserCredentialsRepository});

  @override
  Future<Either<Failure, bool>> call(UserEntity params) {
    return baseUserCredentialsRepository.saveUserCredentials(params);
  }
}
