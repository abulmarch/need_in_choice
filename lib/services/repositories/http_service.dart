import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/services/repositories/repository_urls.dart';







class Repositories {
  static Future<List<AdsModel>> fetchAllAdsData(int page) async {
    try {
      final response = await http.get(Uri.parse('$getAdEndpoint?page=$page'));
      if (response.statusCode == 200) {
        List getAds = jsonDecode(response.body)['result']['data'];

        return getAds.map((ad) => AdsModel.fromJson(ad)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<AccountModels?> fetchAccountsData() async {
    try {
      final response = await http.get(Uri.parse(getAccount));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final accounts = responseData['results'];
        return AccountModels.fromJson(accounts);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
