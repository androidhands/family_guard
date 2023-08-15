import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel(
      {required int id,
      required String mobile,
      required String country,
      required String adminArea,
      required String subAdminArea,
      required String locality,
      required String subLocality,
      required String street,
      required String postalCode,
      required String? updatedAt,
      required String? createdAt,
      required double lat,
      required double lon})
      : super(id, mobile, country, adminArea, subAdminArea, locality,
            subLocality, street, postalCode, updatedAt, createdAt, lat, lon);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        id: json['id'],
        mobile: json['mobile'],
        country: json['country'],
        adminArea: json['admin_area'],
        subAdminArea: json['sub_admin_area'],
        locality: json['locality'],
        subLocality: json['sub_locality'],
        street: json['street'],
        postalCode: json['postal_code'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        lat: json['lat'],
        lon: json['lon']);
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
      'updated_at': updatedAt,
      'created_at': createdAt,
      'lat': lat,
      'lon': lon
    };
  }
}
