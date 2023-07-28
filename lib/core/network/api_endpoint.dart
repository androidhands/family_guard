class ApiEndPoint {
  ///Login Endpoints
  /// SignUp
  static const String apiPassword = "COLgGMo6KEiaY3cFhysY920Kd33SHmGG5cXD";
  static const String manualSignUpPath =
      '/users/register';
  static const String manualSignInPath =
      '/users/login?api_password=$apiPassword';
  static const String logoutPath = '/users/logout?api_password=$apiPassword';

  static const String getAllNotifications = "";
}
