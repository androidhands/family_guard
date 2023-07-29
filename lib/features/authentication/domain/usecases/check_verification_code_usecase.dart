import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/usecases/usecases.dart';

import '../../../../core/error/failure.dart';
import '../repositories/base_forget_password_repository.dart';

class CheckVerificationCodeUsecase
    extends BaseUseCases<String, CheckCodeParams> {
  final BaseForgetPasswordRepository baseForgetPasswordRepository;

  CheckVerificationCodeUsecase({required this.baseForgetPasswordRepository});

  @override
  Future<Either<Failure, String>> call(CheckCodeParams params) {
    return baseForgetPasswordRepository.checkVerificationCode(params);
  }
}

class CheckCodeParams extends Equatable {
  final String phone;
  final String code;

  const CheckCodeParams({required this.phone, required this.code});

  @override
  List<Object?> get props => [phone, code];
}
