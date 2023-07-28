import 'package:family_guard/features/authentication/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel(
      {required id,
      required mobile,
      required country,
      required adminArea,
      required subAdminArea,
      required locality,
      required subLocality,
      required street,
      required postalCode,
      required updatedAt,
      required createdAt})
      : super(id, mobile, country, adminArea, subAdminArea, locality,
            subLocality, street, postalCode, updatedAt, createdAt);

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
        createdAt: json['created_at']);
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
    };
  }
}
