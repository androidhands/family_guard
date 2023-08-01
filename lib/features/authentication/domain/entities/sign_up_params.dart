import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String firstName;
  final String secondName;
  final String familyName;
  final String mobile;
  final String email;
  final String password;
  final String gender;
  String uid;
  final String token;
  final String platform;
  final String imageUrl;
  String country;
  String adminArea;
  String subAdminArea;
  String locality;
  String subLocality;
  String street;
  String postalCode;
  
  double lat;
  double lon;

  SignUpParams(
      {required this.firstName,
      required this.secondName,
      required this.familyName,
      required this.mobile,
      required this.email,
      required this.password,
      required this.gender,
      required this.uid,
      required this.token,
      required this.platform,
      required this.imageUrl,
      required this.country,
      required this.adminArea,
      required this.subAdminArea,
      required this.locality,
      required this.subLocality,
      required this.street,
      required this.postalCode,
  
      required this.lat,
      required this.lon});

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        familyName,
        mobile,
        email,
        password,
        gender,
        uid,
        token,
        platform,
        imageUrl,
        country,
        adminArea,
        subAdminArea,
        locality,
        subLocality,
        street,
        postalCode,
       
        lat,
        lon
      ];

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': secondName,
      'family_name': familyName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'gender': gender,
      'uid': uid,
      'imageUrl': imageUrl,
      'token': token,
      'platform': platform,
      'country': country,
      'admin_area': adminArea,
      'sub_admin_area': subAdminArea,
      'locality': locality,
      'sub_locality': subLocality,
      'street': street,
      'postal_code': postalCode,
      'lat': lat,
      'lon': lon
    };
  }

  set setUid(String u) => uid = u;
  set setCountry(String u) => country = u;
  set setAdmimArea(String u) => adminArea = u;
  set setSubAdminArea(String u) => subAdminArea = u;
  set setLocality(String u) => locality = u;
  set setSubLocality(String u) => subLocality = u;
  set setStreet(String u) => street = u;
  set setPostalCode(String u) => postalCode = u;
  set setLat(double u) => lat = u;
  set setLon(double u) => lon = u;
}
