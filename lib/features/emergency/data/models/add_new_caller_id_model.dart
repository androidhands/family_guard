import 'package:family_guard/features/emergency/domain/entities/add_new_caller_id_entity.dart';

class AddNewCallerIdModel extends AddNewCallerIdEntity {
  AddNewCallerIdModel(
      {required String accountSid,
      required String callSid,
      required String friendlyName,
      required String phoneNumber,
      required String validationCode})
      : super(accountSid, callSid, friendlyName, phoneNumber, validationCode);

  factory AddNewCallerIdModel.fromJson(Map<String, dynamic> json) {
    return AddNewCallerIdModel(
        accountSid: json['accountSid'],
        callSid: json['callSid'],
        friendlyName: json['friendlyName'],
        phoneNumber: json['phoneNumber'],
        validationCode: json['validationCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'accountSid': accountSid,
      'callSid': callSid,
      'friendlyName': friendlyName,
      'phoneNumber': phoneNumber,
      'validationCode': validationCode
    };
  }
}
