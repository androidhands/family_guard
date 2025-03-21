import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

import '../repositories/base_user_credentials_repository.dart';

class GetCachedUserCredentialsUsecase
    extends BaseUseCasesNoParams<UserEntity?> {
  final BaseUserCredentialsRepository baseUserCredentialsRepository;

  GetCachedUserCredentialsUsecase(
      {required this.baseUserCredentialsRepository});

  @override
  Future<Either<Failure, UserEntity?>> call() {
    return baseUserCredentialsRepository.getCachedUserCredentials();
  }
}
