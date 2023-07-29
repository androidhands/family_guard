class ApiEndPoint {
  ///Login Endpoints
  /// SignUp
  static const String apiPassword = "COLgGMo6KEiaY3cFhysY920Kd33SHmGG5cXD";
  static const String manualSignUpPath = '/users/register';
  static const String verifyPhoneNumberPath = '/users/VerifyPhoneNumber';
  static const String checkVerificationCodePath =
      '/users/CheckVerificationCode';
  static const String resetPasswordPath = '/users/ResetPassword';
  static const String manualSignInPath =
      '/users/login?api_password=$apiPassword';
  static const String logoutPath = '/users/logout?api_password=$apiPassword';

  static const String getAllNotifications = "";
//userAddress
  static const String addUserAddressPath = "/users/AddUserAddress";
  static const String getUserAddressPath = "/users/GetUserAddress";
  static const String updateUserAddressPath =
      "/users/UpdateUserAddress?api_password=$apiPassword";
}
