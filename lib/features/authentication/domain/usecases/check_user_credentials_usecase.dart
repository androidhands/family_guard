import 'package:dartz/dartz.dart';

import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_credentials_repository.dart';

import '../../../../core/usecases/usecases.dart';

class CheckUserCredentialsUsecase extends BaseUseCasesNoParams<bool> {
  final BaseUserCredentialsRepository baseUserCredentialsRepository;

  CheckUserCredentialsUsecase({required this.baseUserCredentialsRepository});

  @override
  Future<Either<Failure, bool>> call() async {
    return baseUserCredentialsRepository.checkCashUser();
  }
}
