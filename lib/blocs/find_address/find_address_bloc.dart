import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'find_address_event.dart';
part 'find_address_state.dart';

class FindAddressBloc extends Bloc<FindAddressEvent, FindAddressState> {
  FindAddressBloc() : super(FindAddressInitial()) {
    on<MarkAddress>((event, emit) async {
      final latLng = event.latlng;
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
        );

        if (placemarks.isNotEmpty) {
          final placemark = placemarks[0];
          String currentAddress =
              '${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country},  ${placemark.postalCode} ';
          currentAddress = currentAddress.replaceAll(', ,', ',');
          if(RegExp(r'^\d{6}').hasMatch(currentAddress)){
            currentAddress = currentAddress.replaceRange(0, 8, '');
          }
          if (currentAddress.startsWith(', ')) {
            currentAddress = currentAddress.replaceAll(', ', '');
          }
          emit(AddressLoaded(address: currentAddress, latLng: latLng));
        }
      } catch (e) {
        log('mark address error: $e');
      }
    });

    on<SearchAddress>((event, emit) async {
      try {
        List<Location> locations = await locationFromAddress(event.placeName);

        if (locations.isNotEmpty) {
          Location location = locations[0];

          final latlng = LatLng(location.latitude, location.longitude);
          List<Placemark> placemarks = await placemarkFromCoordinates(
            latlng.latitude,
            latlng.longitude,
          );
          if (placemarks.isNotEmpty) {
            final placemark = placemarks[0];
            String currentAddress =
                '${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country},  ${placemark.postalCode} ';
            currentAddress = currentAddress.replaceAll(', ,', ',');
            if(RegExp(r'^\d{6}').hasMatch(currentAddress)){
              currentAddress = currentAddress.replaceRange(0, 8, '');
            }
            if (currentAddress.startsWith(', ')) {
              currentAddress = currentAddress.replaceAll(', ', '');
            }
            emit(AddressLoaded(address: currentAddress, latLng: latlng));
          }
        }
      } catch (e) {
        log('Error fetching place details: $e');
      }
    });
  }
}
