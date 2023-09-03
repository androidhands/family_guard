import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';

// ignore: must_be_immutable
class TrackingModel extends TrackingEntity {
   TrackingModel({
    required int id,
    required String mobile,
    required String country,
    required String adminArea,
    required String subAdminArea,
    required String locality,
    required String subLocality,
    required String street,
    required String postalCode,
    required double lat,
    required double lon,
    required double speed,
     String? updatedAt,
     String? createdAt,
  }) : super(
            id,
            mobile,
            country,
            adminArea,
            subAdminArea,
            locality,
            subLocality,
            street,
            postalCode,
            lat,
            lon,
            speed,
            updatedAt,
            createdAt);

  factory TrackingModel.fromJson(Map<String, dynamic> json) {
    return TrackingModel(
      id: json['id'],
      mobile: json['mobile'],
      country: json['country'],
      adminArea: json['admin_area'],
      subAdminArea: json['sub_admin_area'],
      locality: json['locality'],
      subLocality: json['sub_locality'],
      street: json['street'],
      postalCode: json['postal_code'],
      lat: json['lat'],
      lon: json['lon'],
      speed: json['speed'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile': mobile,
      'country': country,
      'admin_area': adminArea,
      'sub_admin_area': subAdminArea,
      'locality': locality,
      'sub_locality': subLocality,
      'street': street,
      'postal_code': postalCode,
      'lat': lat,
      'lon': lon,
      'speed': speed,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }
}
