import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String mobile;
  final String password;

  const SignInParams({required this.mobile, required this.password});

  @override
  List<Object?> get props => [
        mobile,
        password,
      ];
  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'password': password,
    };
  }
}
