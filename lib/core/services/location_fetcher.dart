import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:family_guard/core/error/failure.dart';
import 'package:family_guard/core/services/connectivity_services.dart';
import 'package:family_guard/features/home/data/datasource/tracking_data_source.dart';
import 'package:family_guard/features/home/data/models/tracking_model.dart';
import 'package:family_guard/features/home/data/repository/tracking_repository.dart';
import 'package:family_guard/features/home/domain/entity/tracking_entity.dart';
import 'package:family_guard/features/home/domain/usecases/add_new_user_location_usecase.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as gc;

import 'dependency_injection_service.dart';

class LocationFetcher {
  LocationFetcher._();
  static final instance = LocationFetcher._();
  Location location = Location();

  Future<LocationData> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
   /*  if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception();
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        throw Exception();
      }
    } */
    locationData = await location.getLocation();

    try {
      ConnectivityResult connectivityResult =
          await sl<ConnectivityService>().isConnected();
      bool isConnected = (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile);
      location.changeSettings(
        interval: 60000,
        accuracy: LocationAccuracy.high,
      );
      location.enableBackgroundMode(enable: true);
      location.onLocationChanged.listen((LocationData currentLocation) async {
        gc.Placemark placemark = (await gc.placemarkFromCoordinates(
                currentLocation.latitude!, currentLocation.longitude!))
            .first;
        TrackingEntity trackingEntity = TrackingModel(
          id: 0,
          mobile: '',
          country: placemark.country == null || placemark.country!.isEmpty
              ? "No Country"
              : placemark.country!,
          adminArea: placemark.administrativeArea == null ||
                  placemark.administrativeArea!.isEmpty
              ? "No Admin Area"
              : placemark.administrativeArea!,
          subAdminArea: placemark.subAdministrativeArea == null ||
                  placemark.subAdministrativeArea!.isEmpty
              ? "No Sub Admin Area"
              : placemark.subAdministrativeArea!,
          locality: placemark.locality == null || placemark.locality!.isEmpty
              ? "No Locality"
              : placemark.locality!,
          subLocality:
              placemark.subLocality == null || placemark.subLocality!.isEmpty
                  ? "No Sub Locality"
                  : placemark.subLocality!,
          street: placemark.street == null || placemark.street!.isEmpty
              ? "No Street Name"
              : placemark.street!,
          postalCode:
              placemark.postalCode == null || placemark.postalCode!.isEmpty
                  ? "No Postal Code"
                  : placemark.postalCode!,
          lat: currentLocation.latitude ?? 0.0,
          lon: currentLocation.longitude ?? 0.0,
          speed: currentLocation.speed ?? 0.0,
        );
        location.changeNotificationOptions(
            title: 'Family Guard',
            subtitle: 'Geolocation detection ${currentLocation.latitude}',
            iconName: 'ic_bg_service_small');
        if (isConnected == true && serviceEnabled == true) {
          Either<Failure, String> results = await AddNewUserLocationUsecase(
                  baseTrackingRepository: TrackingRepository(
                      baseTrackingDataSource: TrackingDataSource()))(
              TrackingParams(accessToken: '', trackingEntity: trackingEntity));
          results.fold((l) {
            log('Serice locations error ${l.message}');
          }, (r) {
            log('Serice locations $r');
          });
        }
      });
    } catch (e) {
      log('Location Fetcher error ${e.toString()}');
    }

    return locationData;
  }

/*   Future<PermissionStatus> requestLocationPermission() async {
    _permissionGranted = await Location().hasPermission();
    if (_permissionGranted == PermissionStatus.granted ||
        _permissionGranted == PermissionStatus.grantedLimited) {
      return PermissionStatus.granted;
    } else {
      _permissionGranted = await location.requestPermission();
      return _permissionGranted!;
    }
  } */

  /* Future<LocationData> getLocation() async {
    log('getting user location started');
    Location location = Location();
    bool serviceEnabled;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    log('getting user location waiting service enables');
    if (!serviceEnabled) {
      log('getting serive not enabled');
      serviceEnabled = await location.requestService();
      log('getting serive  reques');
      if (!serviceEnabled) {
        log('getting user refused  enable service');
        throw Exception();
      }
    }

    locationData = await location.getLocation();
    log('getting getting location');
    return locationData;
  } */
}
