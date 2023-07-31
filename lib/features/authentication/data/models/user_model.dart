import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required id,
      required firstName,
      required secondName,
      required familyName,
      required mobile,
      required email,
      required gender,
      required emailVerifiedAt,
      required createdAt,
      required updatedAt,
      required apiToken,
      required uid,
      required imageUrl})
      : super(id, firstName, secondName, familyName, mobile, email, gender,
            emailVerifiedAt, createdAt, updatedAt, apiToken, uid,imageUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        secondName: json['last_name'],
        familyName: json['family_name'],
        mobile: json['mobile'],
        email: json['email'],
        gender: json['gender'],
        emailVerifiedAt: json['email_verified_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        apiToken: json['api_token'],
        uid: json['uid'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': secondName,
      'family_name': familyName,
      'mobile': mobile,
      'email': email,
      'gender': gender,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'api_token': apiToken,
      'uid': uid,
      'imageUrl':imageUrl
    };
  }
}
