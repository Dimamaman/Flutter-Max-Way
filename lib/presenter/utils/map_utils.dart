import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../core/model/LocationModel.dart';


Future<void> moveToCurrentLocation(LocationModel locationModel, Completer<YandexMapController> mapController) async {
  (await mapController.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(CameraPosition(
          target:
              Point(latitude: locationModel.lat, longitude: locationModel.long),zoom: 15)));
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return false;
  }

  permission = (await Geolocator.checkPermission());

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  return true;
}


Future<void> getCurrentPosition(
    Function(LocationModel locationModel) callBackLocation) async {
  final hasPermission = await handleLocationPermission();
  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
    print("position :${position}");
    getAddressFromLatLong(position.latitude, position.longitude,
            (locationModel) => locationModel);
  }).catchError((e) {
    print("SSSSSSSS $e");
  });
}

Future<void> getAddressFromLatLong(double lat, double long,
    Function(LocationModel locationModel) callBackLocation) async {
  await placemarkFromCoordinates(lat, long, localeIdentifier: 'en_US')
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    final location = LocationModel(
        cityName: place.locality ?? "",
        regionName: place.administrativeArea ?? "",
        lat: lat,
        street: place.street ?? "",
        long: long);
    print("placemark:$place");
    callBackLocation(location);
  });
}
