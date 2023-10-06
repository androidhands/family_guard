import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_in_repository.dart';

class DeleteUserAccountUsecase extends BaseUseCases<String, String> {
  final BaseManualSignInRepository baseManualSignInRepository;

  DeleteUserAccountUsecase({required this.baseManualSignInRepository});

  @override
  Future<Either<Failure, String>> call(String params) {
    return baseManualSignInRepository.deleteUserAccount(params);
  }
}
