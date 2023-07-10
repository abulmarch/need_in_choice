import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled = false;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

Future<String> getAddressFromLatLon(Position position) async {
  position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation)
      .timeout(const Duration(seconds: 5));

  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String? street = placemarks[0].street;
    String? city = placemarks[0].locality;
    String? state = placemarks[0].administrativeArea;
    String? country = placemarks[0].country;
    String? postalCode = placemarks[0].postalCode;
    return '$street,\n$city,\n$state, $country,\nPincode : $postalCode';
  } catch (err) {
    return "";
  }
}
