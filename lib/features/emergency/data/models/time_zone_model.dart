import 'package:family_guard/features/emergency/domain/entities/time_zone_entity.dart';

class TimeZoneModel extends TimeZoneEntity {
  const TimeZoneModel(
      {required String date,
      required int timezoneType,
      required String timezone})
      : super(date, timezoneType, timezone);

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) {
    return TimeZoneModel(
        date: json['date'],
        timezoneType: json['timezone_type'],
        timezone: json['timezone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'timezone_type': timezoneType,
      'timezone': timezone,
    };
  }
}
