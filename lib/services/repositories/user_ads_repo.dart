import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/ads_models.dart';

const String endpoint = 'http://nic.calletic.com/api/userads/';

class UserAdsRepo {
  getUserAds(String uid) async {
    final url = "$endpoint$uid";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List userAdsList = responseData['result'];
        return userAdsList.map((e) => AdsModel.fromJson(e)).toList();
      } else {
        log('${response.body}fetchSelectedAdsData');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      log('${e}jjjjjjjjjjjjjjjjj');
    }
  }
}
