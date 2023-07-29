import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_forget_password_repository.dart';

class ResetPasswordUsecase
    extends BaseUseCases<UserEntity, ResetPasswordParam> {
  final BaseForgetPasswordRepository baseForgetPasswordRepository;

  ResetPasswordUsecase({required this.baseForgetPasswordRepository});

  @override
  Future<Either<Failure, UserEntity>> call(ResetPasswordParam params) {
    return baseForgetPasswordRepository.resetPassword(params);
  }
}

class ResetPasswordParam extends Equatable {
  final String mobile;
  final String token;
  final String password;

  const ResetPasswordParam(
      {required this.mobile, required this.token, required this.password});

  @override
  List<Object?> get props => [mobile, token, password];
}
