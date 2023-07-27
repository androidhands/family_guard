import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String secondName;
  final String familyName;
  final String mobile;
  final String email;
  final String fbAccount;
  final String applAccount;
  final String googleAccount;
  final String twitterAccount;
  final String notificationKeys;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String gender;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String apiToken;
  final String uid;

  const UserEntity(
      this.id,
      this.firstName,
      this.secondName,
      this.familyName,
      this.mobile,
      this.email,
      this.fbAccount,
      this.applAccount,
      this.googleAccount,
      this.twitterAccount,
      this.notificationKeys,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zipCode,
      this.gender,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.apiToken,
      this.uid);

  @override
  List<Object?> get props => [
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
        uid
      ];
}
