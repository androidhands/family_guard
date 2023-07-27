import 'package:equatable/equatable.dart';
import 'package:family_guard/features/notifications/domain/entities/notification_entity.dart';

class NotificationResponseEntity extends Equatable {
  final List<NotificationEntity> items;
  final int totalCount;

  const NotificationResponseEntity(this.items, this.totalCount);
  
  @override

  List<Object?> get props => [items, totalCount];

}
