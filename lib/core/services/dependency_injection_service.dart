import 'package:family_guard/core/controllers/main_provider.dart';
import 'package:family_guard/features/authentication/presentation/controller/login/login_provider.dart';
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

    initializeMainProvider();

    initializeLogin();
  }

  initializeLocationFetcher() {
    sl.registerLazySingleton<LocationFetcher>(() => LocationFetcher.instance);
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
    sl.registerLazySingleton(() => MainProvider());
  }

  //main provider
  initializeLogin() {
    sl.registerLazySingleton(() => LoginProvider());
  }

 
}
