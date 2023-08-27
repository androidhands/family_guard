import 'package:family_guard/features/notifications/domain/entities/notification_data_entity.dart';

class NotificationDataModel extends NotificationDataEntity {
  const NotificationDataModel(
      {required String uid,
      required String title,
      required String data,
      required String routPath,
      required String imageUrl})
      : super(uid, title, data, routPath, imageUrl);

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
        uid: json['id'],
        title: json['title'],
        data: json['data'],
        routPath: json['routPath'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'data': data,
      'routPath': routPath,
      'imageUrl': imageUrl,
    };
  }
}
