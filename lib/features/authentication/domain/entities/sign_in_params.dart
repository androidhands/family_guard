import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String mobile;
  final String password;
  final String token;
  final String platform;

  const SignInParams({required this.mobile, required this.password,
  required this.token,required this.platform});

  @override
  List<Object?> get props => [
        mobile,
        password,
        token,
        platform
      ];
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'password': password,
      'token':token,
      'platform':platform
    };
  }
}
