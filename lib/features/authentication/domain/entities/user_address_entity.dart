import 'package:equatable/equatable.dart';

class UserAddressEntity extends Equatable {
  final int id;
  final String mobile;
  final String country;
  final String adminArea;
  final String subAdminArea;
  final String locality;
  final String subLocality;
  final String street;
  final String postalCode;
  final String updatedAt;
  final String createdAt;

  const UserAddressEntity(this.id,this.mobile, this.country, this.adminArea, this.subAdminArea, this.locality, this.subLocality,this.street, this.postalCode, this.updatedAt, this.createdAt);
  
  @override

  List<Object?> get props =>[id,mobile, country, adminArea, subAdminArea, locality, subLocality,street, postalCode, updatedAt, createdAt];
}
