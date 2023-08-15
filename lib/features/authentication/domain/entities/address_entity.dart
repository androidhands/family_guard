import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final String mobile;
  final String country;
  final String adminArea;
  final String subAdminArea;
  final String locality;
  final String subLocality;
  final String street;
  final String postalCode;
  final String? updatedAt;
  final String? createdAt;
  final double lat;
  final double lon;

  const AddressEntity(
      this.id,
      this.mobile,
      this.country,
      this.adminArea,
      this.subAdminArea,
      this.locality,
      this.subLocality,
      this.street,
      this.postalCode,
      this.updatedAt,
      this.createdAt,
      this.lat,
      this.lon);

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
        updatedAt,
        createdAt,
        lat,
        lon
      ];
}
