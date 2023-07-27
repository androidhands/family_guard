import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required id,
      required title,
      required body,
      required imageUrl,
      required isReaded,
      required userId,
      required creationTime})
      : super(id, title, body, imageUrl, isReaded, userId, creationTime);

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        imageUrl: json['imageUrl'],
        isReaded: json['isReaded'],
        userId: json['userId'],
        creationTime: json['creationTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'imageUrl': imageUrl,
      'isReaded': isReaded,
      'userId': userId,
      'creationTime': creationTime,
    };
  }
}
