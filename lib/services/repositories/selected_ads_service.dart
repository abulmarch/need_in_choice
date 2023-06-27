import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:need_in_choice/services/repositories/repository_urls.dart';
import '../model/ads_models.dart';




class SelectedAdsRepo {
  Future<AdsModel?> fetchSelectedAdsData(int id) async {
    try {
      final String url = "$getAdEndpoint/$id";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final selectedAds = responseData['result'];
        log(selectedAds.toString());
        return AdsModel.fromJson(selectedAds);
      } else {
        log('${response.body}fetchSelectedAdsData');
        return null;
      }
    } catch (e) {
      log('${e}jjjjjjjjjjjjjjjjj');
      return null;
    }
  }
}
