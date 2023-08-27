import 'package:equatable/equatable.dart';

class MemberEntity extends Equatable {
  final int id;
  final int userId;
  final int memberId;
  final String userRelation;
  final String memberRelation;
  final int accepted;
  int tracked;
  int emergency;
  final String? createdAt;
  final String? updatedAt;

  MemberEntity(
      this.id,
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
        id,
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

  String get requestAccepted {
    switch (accepted) {
      case 0:
        {
          return 'Pending';
        }
      case 1:
        {
          return 'Accepted';
        }
      case 2:
        {
          return 'Canceled';
        }
      case 3:
        {
          return 'Blocked';
        }

      default:
        {
          return 'Pending';
        }
    }
  }

  String get isLocationTracked =>
      tracked == 0 ? 'Location tracked: No' : 'Location tracked: Yes';
  String get isEmergency => tracked == 0 ? 'Emergency: No' : 'Emergency: Yes';

  set setEmergency(int v) => emergency = v;
  set setTracking(int v) => tracked = v;
}
