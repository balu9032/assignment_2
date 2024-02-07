import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng? currentLocation;
bool servicePermission = false;
late LocationPermission permission;
Future<LatLng?> getCurrentLocation() async {
  servicePermission = await Geolocator.isLocationServiceEnabled();
  if (!servicePermission) {}
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }
  Position location = await Geolocator.getCurrentPosition();
  currentLocation = LatLng(location.latitude, location.longitude);
  return currentLocation;
}
