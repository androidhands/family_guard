class ApiEndPoint {
  ///Login Endpoints
  /// SignUp
  static const String signUpSocialMediaPath =
      '/services/app/CM_SignUp/SignUpExternally';

  static const String getServiceProviderTypesPath =
      '/services/ServiceProviderApp/ServiceProvider/GetServiceProviderTypes';

  static const String getActivePhoneCodesPath =
      '/services/ServiceProviderApp/Country/GetActivePhoneCodes';

  /// SignIn
  static const String signInSocialMediaPath =
      '/services/app/CM_SignIn/SignInExternally';
  static const String singInSocialMediaWithAvailableTenant =
      "/services/ServiceProviderApp/SignIn/SignInExternally";

  static const String tenantIdPath =
      "/services/app/SignIn/GetTenantIdByUserMail";

  static const String manualSignInPath =
      "/services/ServiceProviderApp/SignIn/SignInManually";

  ///Complete profile Endpoints
  static const String completeProfilePath =
      '/services/ServiceProviderApp/SignUp/SignUpExternally';

  ///SignUp Endpoints
  static const String manualSignUpPath =
      '/services/ServiceProviderApp/SignUp/SignUpManually';

  ///Active countries Endpoints
  static const String activeCountriesPath =
      "/services/ServiceProviderApp/Country/GetCountries";

  ///Verification
  static const String verifyEmailPath =
      "/services/ServiceProviderApp/Verification/VerifyEmailAddress";
  static const String verifyMobileNumberPath =
      "/services/ServiceProviderApp/Verification/VerifyMobileNumber";

  ///Credentials checker
  static const String checkIfBusinessNameExistsPath =
      '/services/ServiceProviderApp/Tenant/CheckIfBusinessNameExists';

  /// Forget Password
  static const String forgetPasswordByEmailPath =
      "/services/ServiceProviderApp/AccountManger/ForgetPasswordByEmailAddress";
  static const String forgetPasswordByMobilePath =
      "/services/ServiceProviderApp/AccountManger/ForgetPasswordByMobileNumber";
  static const String getAvailableTenantPath =
      '/services/ServiceProviderApp/Tenant/GetAvailableTenants';

  ///Reset New Password
  static const String resetPasswordPath =
      '/services/ServiceProviderApp/AccountManger/ResetPassword';

  /// Get My Details
  static const String myDetailsPath = "/services/app/CM_Client/GetProfile";

  /// Get Available Tenants
  static const String getAvailableTenants =
      "/services/ServiceProviderApp/Tenant/GetAvailableTenants";
  static const String getTenantByUserProvider =
      '/services/ServiceProviderApp/Tenant/GetTenantByUserProvider';

  /// Notifications
  static const String getUnreadCount =
      "/services/ServiceProviderApp/Notifications/GetUnreadedCount";
  static const String getAllNotifications =
      "/services/ServiceProviderApp/Notifications/GetAll";
  static const String getIsReadNotifications =
      "/services/ServiceProviderApp/Notifications/IsRead";

  /// More Screen
  static const String moreDataPath =
      '/services/ServiceProviderApp/ServiceProvider/GetBasicInfo';

  ///home
  static const String getAcceptedProfilePath =
      '/services/ServiceProviderApp/ServiceProvider/GetAcceptedProfile';

  /// profile
  static const String getEmployeeProfile =
      "/services/ServiceProviderApp/Employee/GetProfile";

  ///Organization
  static const String getBusinessInofrmation =
      "/services/ServiceProviderApp/ServiceProvider/GetBusinessInformation";

  ///Branches
  static const String getBranchDetails =
      "/services/ServiceProviderApp/Branch/GetDetails";


  ///Service
  static const String getServiceDetails =
      "/services/ServiceProviderApp/Service/GetDetailes";
}
