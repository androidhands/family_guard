
import 'package:location/location.dart';

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
    if (!serviceEnabled) {
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
    }

   

    locationData = await location.getLocation();
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
