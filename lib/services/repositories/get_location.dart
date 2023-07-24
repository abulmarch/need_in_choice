import 'dart:developer';

import 'package:geocoding/geocoding.dart' show Placemark, placemarkFromCoordinates;
import 'package:geolocator/geolocator.dart';

import '../../blocs/ad_create_or_update_bloc/exception_file.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled = false;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  log("lo $serviceEnabled");
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
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
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
    log(placemarks.first.toString());
    String? street = placemarks.first.street;
    String? city = placemarks.first.locality;
    String? state = placemarks.first.administrativeArea;
    String? country = placemarks.first.country;
    String? postalCode = placemarks.first.postalCode;
    
    return '$street, $city, $state, $country, $postalCode';
  } catch (err) {
    return "";
  }
}



String findPinCode(String text) {
  RegExp pinCodeRegex = RegExp(r'\b\d{6}\b');
  Iterable<Match> matches = pinCodeRegex.allMatches(text);
  if (matches.isEmpty) {
    throw InvalidAddressException();
  }else if(matches.length >1){
    throw InvalidPincodeException();
  }
  // for (Match match in matches) {
  //   log('Pin Code: ${match.group(0)}');
  // }
  final pinCode = matches.first.group(0);
  if (pinCode != null) {
    return pinCode;    
  }else{
    throw PincodeGeneralException();
  }
}

