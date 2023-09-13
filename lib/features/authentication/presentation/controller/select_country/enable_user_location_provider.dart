/* import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';


import 'package:location/location.dart';

import '../../../../../core/global/localization/app_localization.dart';
import '../../../../../core/local_data/shared_preferences_services.dart';

import '../../../../../core/services/dependency_injection_service.dart';
import '../../../../../core/services/location_fetcher.dart';

import '../../../../../core/utils/app_constants.dart';

class EnableUserLocationProvider extends ChangeNotifier {
  EnableUserLocationProvider() {
    init();
  }

  init() async {
    /*   WidgetsBinding.instance.addPostFrameCallback((_) async {
      
    }); */
    String? locale = await sl<SharedPreferencesServices>()
        .getData(key: AppConstants.userStoredLocale, dataType: DataType.string);
    if (locale == null) {
      String defaultLocale = Platform.localeName.split('_')[0];
      log(defaultLocale);
      sl<BaseAppLocalizations>().changeLocale(languageCode: defaultLocale);
    } else {
      sl<BaseAppLocalizations>().changeLocale(languageCode: locale);
    }
  }

  LocationFetcher locationFetcher = sl<LocationFetcher>();

  bool isLoadingLocationService = false;

  checkPermission() async {
    isLoadingLocationService = true;
    notifyListeners();
    LocationData data = await locationFetcher.getLocation();
    setUserLocation(data);

    notifyListeners();
  }

  Future<void> setUserLocation(LocationData locationData) async {
  /*   isLoadingLocationService = true;
    notifyListeners();
    Either<Failure, bool> result = await sl<CacheUserLocationUseCase>()(
        UserLocationParams(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!));
    result.fold((l) async {
      await DialogWidget.showCustomDialog(
          context: Get.context!,
          title: l.message,
          buttonText: tr(AppConstants.ok));
    }, (r) {
      log('success');
    }); */
  }
}
 */