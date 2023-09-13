import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/local_data/shared_preferences_services.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/repository/base_tracking_repository.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:family_guard/features/home/domain/usecases/track_my_members_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class BackgroundDependencyInjection {
  init() async {
    //tracking
    initializeTracking();
    sharedPreferencesInit();
    initializeAPICaller();
    localizationInit();
  }

  initializeTracking() {
    //repository
    sl.registerFactory<BaseTrackingRepository>(
        () => TrackingRepository(baseTrackingDataSource: sl()));

    //usecases
    sl.registerFactory(
        () => AddNewUserLocationUsecase(baseTrackingRepository: sl()));
    sl.registerFactory(
        () => TrackMyMembersUsecase(baseTrackingRepository: sl()));

    //datasources
    sl.registerLazySingleton<BaseTrackingDataSource>(
        () => TrackingDataSource());
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

  void localizationInit() {
    sl.registerLazySingleton<BaseAppLocalizations>(() => AppLocalizations());
  }
}
