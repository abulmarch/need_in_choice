

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:need_in_choice/services/repositories/repository_urls.dart'show ApiEndpoints;
import '../model/ads_models.dart';

class AllAdsRepo {
  static int lastPage = -1;
  Future<List<AdsModel>> fetchAllAdsData(int page) async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.getAdsUrl}?page=$page'));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['result'];
        AllAdsRepo.lastPage = result['last_page'];
        List getAds = result['data'];
        return getAds.map((ad) => AdsModel.fromJson(ad)).toList();
      } else {
        return [];
      }
    } catch (e) {
    log('$e ppppppppp');
      return [];
    }
  }
}