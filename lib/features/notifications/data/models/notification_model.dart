import 'dart:convert';

import 'package:family_guard/features/notifications/data/models/notification_data_model.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_data_entity.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required int id,
      required String type,
      required String notifiableType,
      required int notifiableId,
      required NotificationDataEntity data,
      required String? readAt,
      required String createdAt,
      required String updatedAt,
      required int seen})
      : super(id, type, notifiableType, notifiableId, data, readAt, createdAt,
            updatedAt,seen);

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'],
        type: json['type'],
        notifiableType: json['notifiable_type'],
        notifiableId: json['notifiable_id'],
        data: NotificationDataModel.fromJson(jsonDecode(json['data'])),
        readAt: json['read_at'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        seen: json['seen']);
  }

  /* "id": 1693,
                "type": "App\\Notifications\\LoginNotification",
                "notifiable_type": "App\\Models\\Users",
                "notifiable_id": 10,
                "data": "{\"id\":\"Eb1pWMHa5XfxokxDEuVpZaSSCrQ2\",\"title\":\"Login\",\"data\":\"You have successfully logged in to Family Guard App, Let`s start to protect your family\",\"routPath\":\"\\/\",\"imageUrl\":\"\"}",
                "read_at": null,
                "created_at": "2023-08-19T09:17:37.000000Z",
                "updated_at": "2023-08-19T09:17:37.000000Z" */
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data,
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'seen':seen
    };
  }
}
