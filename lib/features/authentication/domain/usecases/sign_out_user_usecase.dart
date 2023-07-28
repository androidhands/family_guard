
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/usecases/n_usecases.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_in_repository.dart';

import '../../../../core/error/failure.dart';


class SignOutUserUsecase extends NUseCases<bool> {
  final BaseManualSignInRepository baseManualSignInRepository;

  SignOutUserUsecase({required this.baseManualSignInRepository});

  @override
  Future<Either<Failure, bool>> call() {
    return baseManualSignInRepository.signOutUser();
  }
}
