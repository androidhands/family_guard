import 'package:family_guard/features/authentication/data/models/address_model.dart';
import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';
import 'package:family_guard/features/authentication/domain/entities/user_entity.dart';
import 'package:family_guard/features/family/data/model/member_model.dart';
import 'package:family_guard/features/family/domain/entities/member_entity.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required int id,
      required String firstName,
      required String secondName,
      required String familyName,
      required String mobile,
      required String email,
      required String gender,
      required String? emailVerifiedAt,
      required String createdAt,
      required String updatedAt,
      required String? apiToken,
      required String uid,
      required String imageUrl,
      required String country,
      required AddressEntity? address,
      MemberEntity? memberEntity,
      TrackingEntity? trackingEntity})
      : super(
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
            country,
            address,
            memberEntity,
            trackingEntity);

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
        imageUrl: json['imageUrl'],
        country: json['iso'],
        address: json['addresses'] == null
            ? null
            : AddressModel.fromJson(json['addresses']),
        memberEntity: json['pivot'] == null
            ? null
            : MemberModel.fromJson(
                json['pivot'],
              ),
        trackingEntity: json['tracking'] == null
            ? null
            : TrackingModel.fromJson(json['tracking']));
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
      'imageUrl': imageUrl,
      'iso': country,
      'addresses': address,
      'pivot': memberEntity,
      'tracking': trackingEntity
    };
  }
}
