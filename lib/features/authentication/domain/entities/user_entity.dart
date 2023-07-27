import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String secondName;
  final String familyName;
  final String mobile;
  final String email;
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
        gender,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        apiToken,
        uid
      ];
}
