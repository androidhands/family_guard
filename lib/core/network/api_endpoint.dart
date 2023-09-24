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

  static const String getAllNotifications = "/users/GetUserNotifications";
  static const String getNotificationsUnReadCount = "/users/GetUserUnreadCount";

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
  static const String acceptConnectionRequest =
      '/members/AcceptMemberConnection';
  static const String cancelConnectionRequest =
      '/members/CancelMemberConnection';

  //tracking

  static const String addnewUserLocationPath =
      '/tracking/AddCurrentUserLocation';
  static const String trackMyMembersPath =
      '/tracking/TrackMyMembers?api_password=$apiPassword';

  // emergency calls
  static const String checkVerifiedCallerIdPath =
      '/CheckVeriviedCallerId?api_password=$apiPassword';
  static const String addnewCallerIdPath =
      '/AddNewCallerId?api_password=$apiPassword';
  static const String makeEmergencyCallPath = '/MakeCall';
  static const String getCallsLogPath =
      '/GetCallsLogByUser?api_password=$apiPassword';
  static const String getCallLogBySidPath = '/GetCallLogBySid';
   static const String getCallRecordingsBySidPath = '/GetCallLogBySid';
}
