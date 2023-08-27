import 'package:equatable/equatable.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_data_entity.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final NotificationDataEntity data;
  final String? readAt;
  final String createdAt;
  final String updatedAt;
  final int seen;


  const NotificationEntity(
      this.id,
      this.type,
      this.notifiableType,
      this.notifiableId,
      this.data,
      this.readAt,
      this.createdAt,
      this.updatedAt,
      this.seen);

  @override
  List<Object?> get props => [
        id,
        type,
        notifiableType,
        notifiableId,
        data,
        readAt,
        createdAt,
        updatedAt,
        seen
      ];
}
