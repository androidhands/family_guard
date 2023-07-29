import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/usecases/usecases.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_forget_password_repository.dart';

class VerifyUserPhoneUsecase extends BaseUseCases<String, VerifyParams> {
  final BaseForgetPasswordRepository baseForgetPasswordRepository;

  VerifyUserPhoneUsecase({required this.baseForgetPasswordRepository});

  @override
  Future<Either<Failure, String>> call(VerifyParams params) {
    return baseForgetPasswordRepository.verifyUserPhoneNumber(params);
  }
}

class VerifyParams extends Equatable {
  final String phone;
  final String channel;

  const VerifyParams({required this.phone, required this.channel});

  @override
  List<Object?> get props => [phone, channel];
}
