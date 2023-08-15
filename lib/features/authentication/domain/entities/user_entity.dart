import 'package:equatable/equatable.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/family/domain/entities/member_entity.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
  final String? apiToken;
  final String uid;
   String imageUrl;
  final AddressEntity? address;
  final MemberEntity? memberEntity;

   UserEntity(
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
      this.uid,
      this.imageUrl,
      this.address,
      this.memberEntity);

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
        uid,
        imageUrl,
        address,
        memberEntity
      ];

  String get userFullName => '$firstName $secondName $familyName';
  String get userName => '$firstName $secondName';
  set setImageUrl(String v) => imageUrl = v;
}
