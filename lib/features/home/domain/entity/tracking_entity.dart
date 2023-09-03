import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TrackingEntity extends Equatable {
  final int id;
  final String mobile;
  String country;
  String adminArea;
  String subAdminArea;
  String locality;
  String subLocality;
  String street;
  String postalCode;
  double lat;
  double lon;
  double speed;
  final String? updatedAt;
  final String? createdAt;

  TrackingEntity(
    this.id,
    this.mobile,
    this.country,
    this.adminArea,
    this.subAdminArea,
    this.locality,
    this.subLocality,
    this.street,
    this.postalCode,
    this.lat,
    this.lon,
    this.speed,
    this.updatedAt,
    this.createdAt,
  );

  @override
  List<Object?> get props => [
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
        createdAt,
      ];

  set setCountry(String u) => country = u;
  set setAdmimArea(String u) => adminArea = u;
  set setSubAdminArea(String u) => subAdminArea = u;
  set setLocality(String u) => locality = u;
  set setSubLocality(String u) => subLocality = u;
  set setStreet(String u) => street = u;
  set setPostalCode(String u) => postalCode = u;
  set setLat(double u) => lat = u;
  set setLon(double u) => lon = u;
  set setSpeed(double u) => speed = u;

  Map<String, dynamic> toMap() {
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
    };
  }
}
