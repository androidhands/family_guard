import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_in_params.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_in_repository.dart';

class ManualSignInUsecase extends BaseUseCases<UserEntity, SignInParams> {
  final BaseManualSignInRepository baseManualSignInRepository;

  ManualSignInUsecase({required this.baseManualSignInRepository});

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return baseManualSignInRepository.signUpUserManually(params);
  }
}
