import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/data/datasource/base_user_address_data_source.dart';
import 'package:family_guard/features/authentication/data/datasource/base_users_credentials_data_source.dart';
import 'package:family_guard/features/authentication/data/datasource/base_forget_password_data_source.dart';
import 'package:family_guard/features/authentication/data/datasource/base_manual_sing_in_data_source.dart';
import 'package:family_guard/features/authentication/data/repositories/forget_password_repository.dart';
import 'package:family_guard/features/authentication/data/repositories/manual_sign_in_repository.dart';
import 'package:family_guard/features/authentication/data/repositories/manual_sign_up_reposiory.dart';
import 'package:family_guard/features/authentication/data/repositories/user_address_repository.dart';
import 'package:family_guard/features/authentication/data/repositories/user_credentials_repository.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_forget_password_repository.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_in_repository.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_manual_sign_up_repository.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_address_repositoy.dart';
import 'package:family_guard/features/authentication/domain/repositories/base_user_credentials_repository.dart';
import 'package:family_guard/features/authentication/domain/usecases/check_user_credentials_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/check_verification_code_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/get_cached_user_credentials_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/manual_sign_up_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/save_user_address_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/save_user_credentials_usecase.dart';
import 'package:family_guard/features/authentication/domain/usecases/verify_user_phone_usecase.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/login_provider.dart';
import 'package:family_guard/features/authentication/presentation/controller/sign_up_provider.dart';
import 'package:family_guard/features/family/data/data_source/family_connections_data_source.dart';
import 'package:family_guard/features/family/data/repository/family_connection_repositoy.dart';
import 'package:family_guard/features/family/domain/repositories/base_family_connections_repository.dart';
import 'package:family_guard/features/family/domain/usecases/get_family_connections_usecase.dart';
import 'package:family_guard/features/home/presentation/controller/home_provider.dart';
import 'package:family_guard/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:family_guard/features/notifications/data/repositories/notification_count_repository.dart';
import 'package:family_guard/features/notifications/domain/repositories/base_notification_repository.dart';
import 'package:family_guard/features/profile/data/datasource/profile_data_source.dart';
import 'package:family_guard/features/profile/data/repositories/profile_repository.dart';
import 'package:family_guard/features/profile/domain/repositories/base_profile_repository.dart';
import 'package:family_guard/features/profile/domain/usecases/save_profile_image_usecase.dart';
import 'package:family_guard/features/profile/presentation/controllers/profile_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/data/datasource/theme_datasource.dart';
import 'package:family_guard/core/global/theme/data/repositories/theme_repository.dart';
import 'package:family_guard/core/global/theme/domain/repositories/base_theme_repository.dart';
import 'package:family_guard/core/global/theme/domain/usecases/save_theme_usecase.dart';
import 'package:family_guard/core/local_data/shared_preferences_services.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/core/services/firebase_messaging_services.dart';
import 'package:family_guard/core/services/location_fetcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/datasource/base_manual_sign_up_data_source.dart';
import '../../features/authentication/domain/usecases/check_mobile_registered_usecase.dart';
import '../../features/authentication/domain/usecases/manual_sign_in_usecase.dart';
import '../../features/authentication/domain/usecases/reset_password_usecase.dart';
import '../../features/authentication/domain/usecases/sign_out_user_usecase.dart';
import '../../features/authentication/presentation/controller/reset_password_provider.dart';
import '../../features/notifications/domain/usecases/refresh_token_usecase.dart';
import '../../features/notifications/domain/usecases/set_is_read_notification_usecase.dart';
import '../../features/notifications/presentation/controller/notification_provider.dart';
import 'connectivity_services.dart';
import 'date_parser.dart';

final sl = GetIt.instance;

class DependencyInjectionServices {
  init() async {
    ///internet Connection Checker initialize
    internetConnectionCheckerInit();

    /// Shared Preferences  initialize
    await sharedPreferencesInit();

    /// Api caller  initialize
    await initializeAPICaller();

    /// Date Parser  initialize
    initializeDateParser();

    /// Localization  initialize
    localizationInit();

    /// Theme  initialize
    initializeTheme();

    firebaseMessagingInit();
//mainprovider
    initializeMainProvider();
//login
    initializeLogin();

//signup
    initializeSignUp();

    //user address
    initializeUserAddress();

    //forget password
    initializeForgetPassword();

    //notifications
    intializeNotifications();

    //home
    intialozeHome();

    //family
    initializeFamilyConnections();

    //profile
    initializeProfile();
  }

  initializeLocationFetcher() {
    sl.registerLazySingleton<LocationFetcher>(() => LocationFetcher.instance);
    //sl.registerLazySingleton(() => LocationDetectorProvider());
  }

  internetConnectionCheckerInit() async {
    sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  }

  sharedPreferencesInit() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<SharedPreferencesServices>(
        () => SharedPreferencesServicesImpl(prefs: sl()));
  }

  initializeAPICaller() {
    sl.registerLazySingleton<ApiCaller>(() => ApiCaller());
  }

  initializeDateParser() {
    sl.registerLazySingleton<DateParser>(() => DateParser());
  }

  void localizationInit() {
    sl.registerLazySingleton<BaseAppLocalizations>(() => AppLocalizations());
  }

  firebaseMessagingInit() {
    sl.registerLazySingleton<FirebaseMessagingServices>(
        () => FirebaseMessagingServices());
  }

  initializeTheme() {
    // Repositories
    sl.registerLazySingleton<BaseThemeRepository>(
        () => ThemeRepository(baseThemeDataSource: sl()));

    // Use Cases
    sl.registerLazySingleton(() => SaveThemeUseCase(baseThemeRepository: sl()));

    // Data Sources
    sl.registerLazySingleton<BaseThemeDataSource>(() => ThemeDataSource());
  }

  //main provider
  initializeMainProvider() {
    sl.registerFactory(
        () => MainProvider(getCachedUserCredentialsUsecase: sl()));

    //usecases
    sl.registerLazySingleton(
        () => SaveUserCredentialsUsecase(baseUserCredentialsRepository: sl()));
    sl.registerLazySingleton(
        () => CheckUserCredentialsUsecase(baseUserCredentialsRepository: sl()));

    sl.registerLazySingleton(() =>
        GetCachedUserCredentialsUsecase(baseUserCredentialsRepository: sl()));

    sl.registerLazySingleton(
        () => SignOutUserUsecase(baseManualSignInRepository: sl()));

    //repositories
    sl.registerLazySingleton<BaseUserCredentialsRepository>(
        () => UserCredentialsRepository(baseUsersCredentialsDataSource: sl()));

    //datasources
    sl.registerLazySingleton<BaseUsersCredentialsDataSource>(
        () => UsersCredentialsDataSource());
  }

  //main provider
  initializeLogin() {
    sl.registerLazySingleton(() => LoginProvider());

    //repositories
    sl.registerLazySingleton<BaseManualSignInRepository>(
        () => ManualSignInRepository(baseManualSingInDataSource: sl()));

    //usecases
    sl.registerLazySingleton(
        () => ManualSignInUsecase(baseManualSignInRepository: sl()));

    sl.registerLazySingleton<BaseManualSingInDataSource>(
        () => ManualSingInDataSource());
  }

  initializeSignUp() {
    //providers
    sl.registerLazySingleton(() => SignUpProvider());

    //usecases
    sl.registerLazySingleton(
        () => ManualSignUpUsecase(baseManualSignUpRepository: sl()));

    sl.registerLazySingleton(
        () => CheckMobileRegisteredUsecase(baseManualSignUpRepository: sl()));

    //repositories
    sl.registerLazySingleton<BaseManualSignUpRepository>(
        () => ManualSignUpReposiory(baseManualSignUpDataSource: sl()));

    //datasource
    sl.registerLazySingleton<BaseManualSignUpDataSource>(
        () => ManualSignUpDataSource());
  }

  initializeUserAddress() {
    //repository
    sl.registerLazySingleton<BaseUserAddressRepositoy>(
        () => UserAddressRepository(baseUserAddressDataSource: sl()));

    //usecases
    sl.registerLazySingleton(
        () => SaveUserAddressUsecase(baseUserAddressRepositoy: sl()));

    //datasource
    sl.registerLazySingleton<BaseUserAddressDataSource>(
        () => UserAddressDataSource());
  }

  initializeForgetPassword() {
    //provider
    sl.registerLazySingleton(() => ResetPasswordProvider());
    //repositories
    sl.registerLazySingleton<BaseForgetPasswordRepository>(
        () => ForgetPasswordRepository(baseForgetPasswordDataSource: sl()));

    // usecases
    sl.registerLazySingleton(
        () => VerifyUserPhoneUsecase(baseForgetPasswordRepository: sl()));

    sl.registerLazySingleton(
        () => ResetPasswordUsecase(baseForgetPasswordRepository: sl()));

    sl.registerLazySingleton(
        () => CheckVerificationCodeUsecase(baseForgetPasswordRepository: sl()));
    //datasources
    sl.registerLazySingleton<BaseForgetPasswordDataSource>(
        () => ForgetPasswordDataSource());
  }

  intializeNotifications() {
    //providers
    sl.registerFactory(() => NotificationProvider(sl()));

    //repostiories
    sl.registerLazySingleton<BaseNotificationRepository>(
        () => NotificationCountRepository(baseNotificationDataSource: sl()));

    //usecases
    sl.registerLazySingleton(
        () => RefreshTokenUsecase(baseNotificationRepository: sl()));
    sl.registerLazySingleton(
        () => SetIsReadNotificationUseCase(baseNotificationRepository: sl()));

    //datasources
    sl.registerLazySingleton<BaseNotificationDataSource>(
        () => NotificationDataSource());
  }

  intialozeHome() {
    //providers
    // sl.registerLazySingleton(() => HomeControlProvider());
    sl.registerLazySingleton(() => HomeProvider());
  }

  initializeFamilyConnections() {
    //repository
    sl.registerLazySingleton<BaseFamilyConnectionsRepository>(
        () => FamilyConnectionRepositoy(baseFamilyConnectionsDataSource: sl()));

    //usecases
    sl.registerLazySingleton(() =>
        GetFamilyConnectionsUsecase(baseFamilyConnectionsRepository: sl()));

    //repository
    sl.registerLazySingleton<BaseFamilyConnectionsDataSource>(
        () => FamilyConnectionsDataSource());
  }

  initializeProfile() {
    //providers

    sl.registerLazySingleton(() => ProfileProvider());
    //repositories
    sl.registerLazySingleton<BaseProfileRepository>(
        () => ProfileRepository(baseProfileDataSource: sl()));

//usecases
    sl.registerLazySingleton(
        () => SaveProfileImageUsecase(baseProfileRepository: sl()));

    //datasources
    sl.registerLazySingleton<BaseProfileDataSource>(() => ProfileDataSource());
  }
}
