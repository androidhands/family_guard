import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:family_guard/core/services/date_parser.dart';

class NotificationModel {
  String title;
  String body;
  String? imageUrl;
  String? sentTime;
  bool isPinned;
  bool isRead;
  String? routePath;
  int? id;

  NotificationModel({
    required this.title,
    required this.body,
    this.imageUrl,
    this.sentTime,
    required this.isPinned,
    required this.isRead,
    this.routePath,
    this.id,
  });

  factory NotificationModel.fromMap(RemoteMessage event) {
    return NotificationModel(
      sentTime: event.sentTime == null
          ? null
          : DateParser().dateFormatter(event.sentTime!),
      isPinned: !(event.data["IsPinned"].toString().toLowerCase() == 'false'),
      isRead: !(event.data["IsReaded"].toString().toLowerCase() == 'false'),
      routePath: event.data["RoutePath"],
      body: event.data['body'] ?? '',
      imageUrl: event.data['imageUrl'] ?? '',
      title: event.data['title'] ?? '',
      id: int.tryParse(event.data['id'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "IsPinned": isPinned,
      "IsReaded": isRead,
      "RoutePath": routePath,
      "body": body,
      "imageUrl": imageUrl,
      "title": title,
      "sentTime": sentTime,
      "id": id
    };
  }
}
