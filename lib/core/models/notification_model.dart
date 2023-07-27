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
      body: event.data['Body'] ?? '',
      imageUrl: event.data['ImageUrl'] ?? '',
      title: event.data['Title'] ?? '',
      id: int.tryParse(event.data['Id'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "IsPinned": isPinned,
      "IsReaded": isRead,
      "RoutePath": routePath,
      "Body": body,
      "ImageUrl": imageUrl,
      "Title": title,
      "sentTime": sentTime,
      "Id": id
    };
  }
}
