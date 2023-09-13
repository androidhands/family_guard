import 'package:equatable/equatable.dart';
import 'package:family_guard/features/emergency/domain/entities/sub_resource_uris_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/time_zone_entity.dart';

class PhoneCallEntity extends Equatable {
  int? id;
  String? sid;
  dynamic dateCreated;
  dynamic? dateUpdated;
  String? parentCallSid;
  String? accountSid;
  String? to;
  String? toFormatted;
  String? from;
  String? fromFormatted;
  String? phoneNumberSid;
  String? status;
  dynamic startTime;
  dynamic endTime;
  String? duration;
  String? price;
  String? priceUnit;
  String? direction;
  String? answeredBy;
  String? apiVersion;
  String? forwardedFrom;
  String? groupSid;
  String? callerName;
  String? queueTime;
  String? trunkSid;
  String? uri;
  SubresourceUrisEntity? subresourceUris;
  String emergencyType;
  double lat;
  double lon;
  String street;
  String city;
  String state;
  String country;

  var postalCode;

  PhoneCallEntity(
      this.id,
      this.sid,
      this.dateCreated,
      this.dateUpdated,
      this.parentCallSid,
      this.accountSid,
      this.to,
      this.toFormatted,
      this.from,
      this.fromFormatted,
      this.phoneNumberSid,
      this.status,
      this.startTime,
      this.endTime,
      this.duration,
      this.price,
      this.priceUnit,
      this.direction,
      this.answeredBy,
      this.apiVersion,
      this.forwardedFrom,
      this.groupSid,
      this.callerName,
      this.queueTime,
      this.trunkSid,
      this.uri,
      this.subresourceUris,
      this.emergencyType,
      this.lat,
      this.lon,
      this.street,
      this.state,
      this.city,
      this.country);

  @override
  List<Object?> get props => [
        id,
        sid,
        dateCreated,
        dateUpdated,
        parentCallSid,
        accountSid,
        to,
        toFormatted,
        from,
        fromFormatted,
        phoneNumberSid,
        status,
        startTime,
        endTime,
        duration,
        price,
        priceUnit,
        direction,
        answeredBy,
        apiVersion,
        forwardedFrom,
        groupSid,
        callerName,
        queueTime,
        trunkSid,
        uri,
        subresourceUris,
        emergencyType,
        lat,
        lon,
        street,
        state,
        city,
        country
      ];
}
