import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' show XFile;

import 'package:need_in_choice/services/repositories/repository_urls.dart'show ApiEndpoints;
import '../model/ad_create_or_update_model.dart';

class CreateOrUpdateAdsRepo {
  Future<AdCreateOrUpdateModel> fetchAdDataToUpdate(int id) async {
    try {
      final response = await http.get(Uri.parse("${ApiEndpoints.getAdsUrl}/$id"));

      if (response.statusCode == 200) { 
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final selectedAds = responseData['result'];
        return AdCreateOrUpdateModel.fromJson(selectedAds);
      } else {
        log('${response.body} fetched AdsData to update');
        throw FaildToFindAdException();
      }
    } catch (e) {
      log(e.toString());
      throw e is FaildToFindAdException ? 'Faild to find data' : 'Something went wrong';
    }
  }
  Future<void> updateOrCreateAd(AdCreateOrUpdateModel adData) async {
    //                                       updation                          creation
    final String apiUrl = adData.id != null ? ApiEndpoints.updateAdUrl(adData.id!) : ApiEndpoints.createAdsUrl;
    try {
      Map<String, String> dataToUpload = {
        'user_id': adData.userId,
        'ads_title':adData.adsTitle,
        'description':adData.description,
        'is_premium':adData.isPremium ? '1' : '0',
        'primary_details':jsonEncode(adData.primaryData),
        'more_info':jsonEncode(adData.moreInfoData),
        'ads_address':adData.adsAddress,
        'ads_levels':jsonEncode(adData.adsLevels),
        'main_category':adData.mainCategory,
        'other_image_to_delete': jsonEncode(adData.otherImgUrlsToDelete),
        'ads_image_to_delete': jsonEncode(adData.urlsToDelete),
        'ad_price' : jsonEncode(adData.adPrice),
        'pincode': adData.pinCode,
      };
      final url = Uri.parse(apiUrl);
      final request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Accept'] = 'application/json';
      request.fields.addAll(dataToUpload);

      for (var xFile in adData.imageFiles) {
        try {
          request.files.add(
            await http.MultipartFile.fromPath('images[]', xFile.path),
          );
        } catch (e) {
          log('emage upload error: $e\n img: ${xFile.path}');
        }
      }

      for (Map mapData in adData.otherImageFiles) {
        try {
          final filePath = (mapData['file'] as XFile).path;
          final imageType = mapData['image_type'];
          log('=====>>>$filePath');
          request.files.add(
            await http.MultipartFile.fromPath('other_ads_image[$imageType]', filePath),
          );
        } catch (e) {
          log('emage upload error: $e\n img: $mapData');
        }
      }

      await request.send().then((streamedResponse) async {
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode != 200) {
          log(response.body);
          throw FaildToUploadDataException();
        }
        log(response.statusCode.toString());
        log(response.body);
      });      
    } catch (e) {
        throw FaildToUploadDataException();
    }
  }
}

class FaildToFindAdException implements Exception{}

class FaildToUploadDataException implements Exception{}