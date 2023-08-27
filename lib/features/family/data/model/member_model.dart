import 'package:family_guard/features/family/domain/entities/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel(
      {required int id,
      required int userId,
      required int memberId,
      required String userRelation,
      required String memberRelation,
      required int accepted,
      required int tracked,
      required int emergency,
      String? createdAt,
      String? updatedAt})
      : super(id, userId, memberId, userRelation, memberRelation, accepted,
            tracked, emergency, createdAt, updatedAt);

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
        id: json['id'],
        userId: json['user_id'],
        memberId: json['member_id'],
        userRelation: json['user_relation'],
        memberRelation: json['member_relation'],
        accepted: json['accepted'],
        tracked: json['track'],
        emergency: json['emergency'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'member_id': memberId,
      'user_relation': userRelation,
      'member_relation': memberRelation,
      'accepted': accepted,
      'track': tracked,
      'emergency': emergency,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
