import 'package:equatable/equatable.dart';

class SendCodeResultEntity extends Equatable {
  final String user;
  final String token;
  final String activationCode;
  final String? newPassword;
  final String? confirmPassword;
  final String? userName;
  final bool isAutomaticSignIn;

  const SendCodeResultEntity(
      this.user,
      this.token,
      this.activationCode,
      this.newPassword,
      this.confirmPassword,
      this.userName,
      this.isAutomaticSignIn);

  @override
  List<Object?> get props => [
        user,
        token,
        activationCode,
        newPassword,
        confirmPassword,
        userName,
        isAutomaticSignIn
      ];
}
