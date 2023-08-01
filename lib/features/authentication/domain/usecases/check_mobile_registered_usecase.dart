import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_up_repository.dart';

class CheckMobileRegisteredUsecase extends BaseUseCases<bool, String> {
  final BaseManualSignUpRepository baseManualSignUpRepository;

  CheckMobileRegisteredUsecase({required this.baseManualSignUpRepository});

  @override
  Future<Either<Failure, bool>> call(String params) {
    return baseManualSignUpRepository.checkMobileRegistered(params);
  }
}
