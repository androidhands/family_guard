import 'package:family_guard/features/notifications/data/models/notification_model.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_response_entity.dart';

class NotificationResponseModel extends NotificationResponseEntity {
  const NotificationResponseModel(
      {required List<NotificationEntity> items, required int totalCount})
      : super(items, totalCount);

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
        items: List<NotificationEntity>.from(json['items'].map((e) => NotificationModel.fromJson(e))).toList(),
        totalCount: json['totalCount']);
  }

  Map<String, dynamic> toJson() {
    return {'items': items, 'totalCount': totalCount};
  }
}
