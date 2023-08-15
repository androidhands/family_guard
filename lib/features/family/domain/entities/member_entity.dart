import 'package:equatable/equatable.dart';

class MemberEntity extends Equatable {
  final int userId;
  final int memberId;
  final String userRelation;
  final String memberRelation;
  final int? accepted;
  final int? tracked;
  final int? emergency;
  final String? createdAt;
  final String? updatedAt;

  const MemberEntity(
      this.userId,
      this.memberId,
      this.userRelation,
      this.memberRelation,
      this.accepted,
      this.tracked,
      this.emergency,
      this.createdAt,
      this.updatedAt);

  @override
  List<Object?> get props => [
        userId,
        memberId,
        userRelation,
        memberRelation,
        accepted,
        tracked,
        emergency,
        createdAt,
        updatedAt
      ];
}
