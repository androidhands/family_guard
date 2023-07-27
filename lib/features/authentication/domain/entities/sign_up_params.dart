import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String firstName;
  final String secondName;
  final String familyName;
  final String mobile;
  final String email;
  final String password;
  final String gender;
  String uid;

  SignUpParams(
      {required this.firstName,
      required this.secondName,
      required this.familyName,
      required this.mobile,
      required this.email,
      required this.password,
      required this.gender,
      required this.uid});

  @override
  List<Object?> get props =>
      [firstName, secondName, familyName, mobile, email, password, gender, uid];

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': secondName,
      'family_name': familyName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'gender': gender,
      'uid': uid
    };
  }

  set setUid(String u) => uid = u;
}
