

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:need_in_choice/services/repositories/repository_urls.dart';
import '../model/ads_models.dart';

class AllAdsRepo {
  static int lastPage = -1;
  Future<List<AdsModel>> fetchAllAdsData(int page) async {
    // final ads = AdsModel(id: 1, userId: '2', adsTitle: 'adsTitle', description: 'description', isPremium: true, mainCategory: 'mainCategory', createdDate: 'createdDate', images: [], realEstate: {}, timeAgo: 'timeAgo');

    // print('------------1-----------');
    try {
      final response = await http.get(Uri.parse('$getAdEndpoint?page=$page'));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['result'];
        // print('-----------4------------');
        AllAdsRepo.lastPage = result['last_page'];
        // print('-----------5------------');
        List getAds = result['data'];
        // print('-----------6------------');
        return getAds.map((ad) => AdsModel.fromJson(ad)).toList();
      } else {
        print('-----------7------------');
        return [];
      }
    } catch (e) {
      print('---------8--------------');
    log(e.toString()+'ppppppppp');
      return [];
    }
  }
}