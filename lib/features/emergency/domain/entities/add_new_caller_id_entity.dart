import 'package:equatable/equatable.dart';
/*{
        "accountSid": "AC079c39fd77cf487f99a27a7a52756c24",
        "callSid": "CAf013f002c67685982c500ef3630a0a32",
        "friendlyName": "Abdelhamid",
        "phoneNumber": "+201115583344",
        "validationCode": "630635"
    }, */
class AddNewCallerIdEntity extends Equatable{
 String accountSid;
  String callSid;
  String friendlyName;
  String phoneNumber;
  String validationCode;

  AddNewCallerIdEntity(
      this.accountSid,
      this.callSid,
      this.friendlyName,
      this.phoneNumber,
      this.validationCode);
      
        @override
        
        List<Object?> get props =>[accountSid,
      callSid,
      friendlyName,
      phoneNumber,
      validationCode];

}