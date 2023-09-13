import 'dart:convert';

import 'package:family_guard/features/emergency/data/models/sub_resource_model.dart';
import 'package:family_guard/features/emergency/data/models/time_zone_model.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/sub_resource_uris_entity.dart';
import 'package:family_guard/features/emergency/domain/entities/time_zone_entity.dart';

class PhoneCallModel extends PhoneCallEntity {
  PhoneCallModel(
      {required int? id,
      required String? sid,
      required dynamic dateCreated,
      required dynamic dateUpdated,
      required String? parentCallSid,
      required String? accountSid,
      required String? to,
      required String? toFormatted,
      required String? from,
      required String? fromFormatted,
      required String? phoneNumberSid,
      required String? status,
      required dynamic startTime,
      required dynamic endTime,
      required String? duration,
      required String? price,
      required String? priceUnit,
      required String? direction,
      required String? answeredBy,
      required String? apiVersion,
      required String? forwardedFrom,
      required String? groupSid,
      required String? callerName,
      required String? queueTime,
      required String? trunkSid,
      required String? uri,
      required SubresourceUrisEntity? subresourceUris,
      required String emergencyType,
      required double lat,
      required double lon,
      required String street,
      required String city,
      required String state,
      required String country})
      : super(
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
            country);

  factory PhoneCallModel.fromJson(Map<String?, dynamic> json) {
    return PhoneCallModel(
      id: json['id'],
      sid: json['sid'],
      dateCreated: json['dateCreated'] == null
          ? null
          : json['dateCreated'] is String
              ? json['dateCreated']
              : TimeZoneModel.fromJson(json['dateCreated']),
      dateUpdated: json['dateUpdated'] == null
          ? null
          : json['dateCreated'] is String
              ? json['dateCreated']
              : TimeZoneModel.fromJson(json['dateUpdated']),
      parentCallSid: json['parentCallSid'],
      accountSid: json['accountSid'],
      to: json['to'],
      toFormatted: json['toFormatted'],
      from: json['from'],
      fromFormatted: json['fromFormatted'],
      phoneNumberSid: json['phoneNumberSid'],
      status: json['status'],
      startTime: json['startTime'] == null
          ? null
          : json['dateCreated'] is String
              ? json['dateCreated']
              : TimeZoneModel.fromJson(json['startTime']),
      endTime: json['endTime'] == null
          ? null
          : json['dateCreated'] is String
              ? json['dateCreated']
              : TimeZoneModel.fromJson(json['endTime']),
      duration: json['duration'],
      price: json['price'],
      priceUnit: json['priceUnit'],
      direction: json['direction'],
      answeredBy: json['answeredBy'],
      apiVersion: json['apiVersion'],
      forwardedFrom: json['forwardedFrom'],
      groupSid: json['groupSid'],
      callerName: json['callerName'],
      queueTime: json['queueTime'],
      trunkSid: json['trunkSid'],
      uri: json['uri'],
      subresourceUris: json['subresourceUris'] == null
          ? null
          : json['subresourceUris'] is String
              ? SubResourceModel.fromJson(jsonDecode(json['subresourceUris']))
              : SubResourceModel.fromJson(json['subresourceUris']),
      emergencyType: json['emergency_type'],
      lat: json['lat'],
      lon: json['lon'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      'sid': sid,
      'dateCreated': dateCreated,
      'dateUpdated': dateUpdated,
      'parentCallSid': parentCallSid,
      'accountSid': accountSid,
      'to': to,
      'toFormatted': toFormatted,
      'from': from,
      'fromFormatted': fromFormatted,
      'phoneNumberSid': phoneNumberSid,
      'status': status,
      'startTime': startTime,
      'endTime': endTime,
      'duration': duration,
      'price': price,
      'priceUnit': priceUnit,
      'direction': direction,
      'answeredBy': answeredBy,
      'apiVersion': apiVersion,
      'forwardedFrom': forwardedFrom,
      'groupSid': groupSid,
      'callerName': callerName,
      'queueTime': queueTime,
      'trunkSid': trunkSid,
      'uri': uri,
      'subresourceUris': subresourceUris,
      'emergency_type': emergencyType,
      'lat': lat,
      'lon': lon,
      'street': street,
      'state': state,
      'city': city,
      'country': country
    };
  }
}
