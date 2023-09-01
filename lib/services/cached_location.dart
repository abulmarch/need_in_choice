import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http show post;
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/views/pages/login/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/pages/home_page/network_util.dart';
import 'model/autocomplete_prediction.dart';
import 'repositories/key_information.dart';
import 'repositories/repository_urls.dart';

class CacheLocation {
  late final SharedPreferences _prefs;
  List<CachedLocationData> predictions = [];
  initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _getAddressFromLocally();
  }

  saveAddressLocally(CachedLocationData cachedLocationData) {
    try {
      predictions.add(cachedLocationData);
      List<Map<String, dynamic>> savingData =
          predictions.map((e) => e.toJson()).toList();
      _prefs.setString('addressList', jsonEncode(savingData));
    } catch (e) {
      log(' saveAddressLocally  : saveAddressLocally   ');
    }
  }

  Future<Map<String, dynamic>?> getCurrentAddressFromLocal() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? currentAddress = preference.getString('currentAddress');
    try {
      final Map<String, dynamic> address = jsonDecode(currentAddress!);

      print('--------------------current: $currentAddress');
      return address;
    } catch (e) {
      log("Error decoding address from local storage: $e");
    }
    return null;
  }

  Future<void> saveCurrentAddressLocally(Map<String, dynamic> addressData) async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    try {
      String jsonString = jsonEncode(addressData);
      await preference.setString('currentAddress', jsonString);
      print('Saved address locally: $jsonString');
    } catch (e) {
      print('Error saving address locally: $e');
    }
  }

  _getAddressFromLocally() {
    final String? addressList = _prefs.getString('addressList');
    if (addressList != null) {
      try {
        final List parsed = jsonDecode(addressList);
        predictions = parsed
            .map((cachedData) => CachedLocationData.fromJson(cachedData))
            .toList();
      } catch (e) {
        log('ooooooooooooo eeee   $e');
      }
    }
  }

  Future<bool> finadPlaceDetails(
      {required AutocompletePrediction prediction,
      required BuildContext context}) async {
    //https://maps.googleapis.com/maps/api/place/details/json
    Uri uri = Uri.https('maps.googleapis.com', 'maps/api/place/details/json', {
      "place_id": prediction.placeId,
      "key": kGooglePlaceSearchKey,
      "fields": "address_component",
    });
    log(uri.toString());
    String? response = await NetworkUtility.finaPlaceId(uri);
    if (response != null) {
      PlaceDetails result = PlaceDetails.parsePincode(response);
      final cachedLocationData =
          CachedLocationData(prediction: prediction, placeDetails: result);
      await saveDataToUserProfile(cachedLocationData, context);
      saveAddressLocally(cachedLocationData);
      log('ppppppppppppppppppp');
    }
    return true;
  }

  saveDataToUserProfile(
      CachedLocationData cachedLocationData, BuildContext context) async {
    final account = AccountSingleton().getAccountModels;
    BlocProvider.of<AuthBloc>(context).add(UpdateAccountDataEvent(
        accountData: account.copyWith(
            selectedPlace: cachedLocationData.prediction.description,
            placePincode: cachedLocationData.placeDetails.pinCode)));
    // log(cachedLocationData.prediction.toString());
    // try{
    //   final apiUrl = Uri.parse(ApiEndpoints.updateUserAccountUrl);
    //   final response = await http.post(
    //     apiUrl,
    //     body: {
    //       'id': '${AccountSingleton().getAccountModels.id}',
    //       'user_id': AccountSingleton().getAccountModels.userId,
    //       'selected_place': cachedLocationData.prediction.description,
    //       'place_pincode': cachedLocationData.placeDetails.pinCode,
    //     }
    //   );
    //   if (response.statusCode == 200) {
    //     log('----response.body--${response.body}------- ');
    //   }
    //   log('----response.statusCode-${response.statusCode}   ${response.body}------- ');
    // }catch(e){
    //   log('----saveDataToUserProfile-- $e ------- ');
    // }
  }
}

class PlaceDetails {
  final String pinCode;
  PlaceDetails({required this.pinCode});

  static PlaceDetails parsePincode(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<String, dynamic>();
    return PlaceDetails.fromJson(parsed);
  }

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    RegExp pinCodeRegex = RegExp(r'\b\d{6}\b');
    log(json.toString());
    List result = json['result']['address_components'];
    final addressComponents = result
        .firstWhere((element) => pinCodeRegex.hasMatch(element['long_name']));
    return PlaceDetails(pinCode: addressComponents['long_name']);
  }

  @override
  String toString() {
    return pinCode;
  }
}

class CachedLocationData {
  final AutocompletePrediction prediction;
  final PlaceDetails placeDetails;
  CachedLocationData({required this.prediction, required this.placeDetails});

  factory CachedLocationData.fromJson(json) {
    return CachedLocationData(
      prediction: AutocompletePrediction.fromJson(json['prediction']),
      placeDetails: PlaceDetails(pinCode: json['pincode']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'prediction': prediction.toJson(),
      'pincode': placeDetails.toString(),
    };
  }
}
