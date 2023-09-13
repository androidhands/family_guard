import 'package:equatable/equatable.dart';

class TimeZoneEntity extends Equatable {
  final String date;
  final int timezoneType;
  final String timezone;

  const TimeZoneEntity(this.date, this.timezoneType, this.timezone);
  @override
  List<Object?> get props => [date, timezoneType, timezone];
}
