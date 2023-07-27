import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required id,
      required firstName,
      required secondName,
      required familyName,
      required mobile,
      required email,
      required fbAccount,
      required applAccount,
      required googleAccount,
      required twitterAccount,
      required notificationKeys,
      required address,
      required city,
      required state,
      required country,
      required zipCode,
      required gender,
      required emailVerifiedAt,
      required createdAt,
      required updatedAt,
      required apiToken,
      required uid})
      : super(
            id,
            firstName,
            secondName,
            familyName,
            mobile,
            email,
            fbAccount,
            applAccount,
            googleAccount,
            twitterAccount,
            notificationKeys,
            address,
            city,
            state,
            country,
            zipCode,
            gender,
            emailVerifiedAt,
            createdAt,
            updatedAt,
            apiToken,
            uid);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        secondName: json['last_name'],
        familyName: json['family_name'],
        mobile: json['mobile'],
        email: json['email'],
        fbAccount: json['fbaccount'],
        applAccount: json['applaccount'],
        googleAccount: json['googleaccount'],
        twitterAccount: json['twitteraccount'],
        notificationKeys: json['notificationKeys'],
        address: json['address'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        zipCode: json['zipCode'],
        gender: json['gender'],
        emailVerifiedAt: json['emailVerifiedAt'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        apiToken: json['apiToken'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': secondName,
      'family_name': familyName,
      'mobile': mobile,
      'email': email,
      'fbaccount': fbAccount,
      'googleaccount': googleAccount,
      'twitteraccount': twitterAccount,
      'notification_keys': notificationKeys,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zip_code': zipCode,
      'gender': gender,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'api_token': apiToken,
      'uid': uid,
    };
  }
}
