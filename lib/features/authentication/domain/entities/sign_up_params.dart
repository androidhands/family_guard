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
  final String token;
  final String platform;
  final String imageUrl;

  SignUpParams(
      {required this.firstName,
      required this.secondName,
      required this.familyName,
      required this.mobile,
      required this.email,
      required this.password,
      required this.gender,
      required this.uid,
      required this.token,
      required this.platform,
      required this.imageUrl});

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        familyName,
        mobile,
        email,
        password,
        gender,
        uid,
        token,
        platform,
        imageUrl
      ];

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': secondName,
      'family_name': familyName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'gender': gender,
      'uid': uid,
      'imageUrl': imageUrl,
      'token': token,
      'platform': platform
    };
  }

  set setUid(String u) => uid = u;
}
