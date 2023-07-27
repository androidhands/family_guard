getSocialMediaAuthenticationJson({
  String? firstName,
  String? lastName,
  String? emailAddress,
  String? mobileNumber,
  int? phoneCodeCountryId,
  required String providerKey,
  required String provider,
  String? imageUrl,
}) {
  return {
    "firstName": firstName,
    "lastName": lastName,
    "emailAddress": emailAddress,
    "providerKey": providerKey,
    "mobileNumber": mobileNumber,
    "isEmailConfirmed": emailAddress != null ? true : false,
    "isPhoneConfirmed": mobileNumber != null ? true : false,
    'provider': provider,
    "imageUrl": imageUrl,
  }..removeWhere((key, value) => value == null);
}

///Saudi Arabia ID
const saID = 103;

//PC = Phone Code
const bahrainPC = '+973';
const egyPC = '+20';
const saPC = '+966';
const uaePC = '+971';
const qatarPC = '+974';
const omanPC = '+968';
const kuwaitPC = '+965';

int getMinLengthFromPhoneCode(String? phoneCode) {
  switch (phoneCode) {
    case bahrainPC:
    case qatarPC:
    case omanPC:
    case kuwaitPC:
      return 8;
    case uaePC:
    case saPC:
      return 9;
    case egyPC:
      return 10;
    default:
      return 10;
  }
}
int getMaxLengthFromPhoneCode(String? phoneCode) {
  switch (phoneCode) {
    case bahrainPC:
    case qatarPC:
    case omanPC:
    case kuwaitPC:
      return 8;
    case uaePC:
    case saPC:
    case egyPC:
      return 10;
    default:
      return 10;
  }
}
