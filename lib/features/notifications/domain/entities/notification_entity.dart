import 'package:equatable/equatable.dart';

import '../../../general/data/models/name_model.dart';
import '../../../general/domain/entities/name.dart';

class NotificationEntity extends Equatable {
  final int id;

  final Map<String, dynamic> title;
  final Map<String, dynamic> body;
  final String imageUrl;
  final bool isReaded;
  final int userId;
  final String creationTime;

  const NotificationEntity(this.id, this.title, this.body, this.imageUrl,
      this.isReaded, this.userId, this.creationTime);

  @override
  List<Object?> get props =>
      [id, title, body, imageUrl, isReaded, userId, creationTime];

  Name get titleStr => NameModel.fromMap(title);

  Name get bodyStr => NameModel.fromMap(body);

  Map<String, dynamic> toMap() {
    return {'id': id};
  }
}
