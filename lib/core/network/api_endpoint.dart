class ApiEndPoint {
  ///Login Endpoints
  /// SignUp
  static const String apiPassword = "COLgGMo6KEiaY3cFhysY920Kd33SHmGG5cXD";
  static const String checkMobileRegisteredPath =
      '/users/CheckMobileRegistered';
  static const String manualSignUpPath = '/users/register';
  static const String verifyPhoneNumberPath = '/users/VerifyPhoneNumber';
  static const String checkVerificationCodePath =
      '/users/CheckVerificationCode';
  static const String resetPasswordPath = '/users/ResetPassword';
  static const String manualSignInPath =
      '/users/login?api_password=$apiPassword';
  static const String logoutPath = '/users/logout?api_password=$apiPassword';

  static const String getAllNotifications = "";

  //notifications
  static const String addFCMTokenPath = "/users/AddFCMToken";
//userAddress
  static const String addUserAddressPath = "/users/AddUserAddress";
  static const String getUserAddressPath =
      "/users/GetUserAddress?api_password=$apiPassword";
  static const String updateUserAddressPath =
      "/users/UpdateUserAddress?api_password=$apiPassword";

  static const String userImagePath = "/GetUserImage/";

  static const String saveUserProfileImagePath = "/users/SaveUserImage";

  //membets
  static const String memberImagePath = "api/members/GetMemberProfile";
  static const String getFamilyConnectionsPath =
      '/members/GetUserMembers?api_password=$apiPassword';
  static const String addNewFamilyConnectionsPath = '/members/AddNewMember';

  static const String getSentMembersRequests =
      '/members/GetSentMembersRequests?api_password=$apiPassword';
  static const String getReceivedMembersRequest =
      '/members/GetReceivedMembersRequest?api_password=$apiPassword';
}
