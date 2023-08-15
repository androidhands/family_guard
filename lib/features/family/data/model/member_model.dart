import 'package:family_guard/features/family/domain/entities/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel(
      {required userId,
      required memberId,
      required userRelation,
      required memberRelation,
      required accepted,
      required tracked,
      required emergency,
      String? createdAt,
      String? updatedAt})
      : super(userId, memberId, userRelation, memberRelation, accepted, tracked,
            emergency, createdAt, updatedAt);

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        userId: json['user_id'],
        memberId: json['member_id'],
        userRelation: json['user_relation'],
        memberRelation: json['member_relation'],
        accepted: json['accepted'],
        tracked: json['tracked'],
        emergency: json['emergency'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'member_id': memberId,
      'user_relation': userRelation,
      'member_relation': memberRelation,
      'accepted': accepted,
      'tracked': tracked,
      'emergency': emergency,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
