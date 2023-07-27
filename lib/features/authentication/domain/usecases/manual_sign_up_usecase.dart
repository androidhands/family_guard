import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/sign_up_params.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_up_repository.dart';

class ManualSignUpUsecase extends BaseUseCases<UserEntity, SignUpParams> {
  final BaseManualSignUpRepository baseManualSignUpRepository;

  ManualSignUpUsecase({required this.baseManualSignUpRepository});

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return baseManualSignUpRepository.signUpUserManually(params);
  }
}
