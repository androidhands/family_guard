///forget_password_verification_entity
import 'package:family_guard/features/authentication/domain/entities/send_code_result_entity.dart';
import 'package:equatable/equatable.dart';


class ForgetPasswordVerificationEntity extends Equatable {
  final bool isPhone;
  final String? phoneCode;
  final String emailOrPhone;
  final SendCodeResultEntity sendCodeResultEntity;
  final int tenantId;

  const ForgetPasswordVerificationEntity(
      {required this.sendCodeResultEntity,
      required this.emailOrPhone,
      this.phoneCode,
      required this.tenantId,
      required this.isPhone});

  @override
  List<Object?> get props => [
        sendCodeResultEntity,
        emailOrPhone,
        phoneCode,
        isPhone,
        tenantId,
      ];
}
