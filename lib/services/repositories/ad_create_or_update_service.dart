import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' show XFile;

import 'package:need_in_choice/services/repositories/repository_urls.dart';
import '../model/ad_create_or_update_model.dart';

class CreateOrUpdateAdsRepo {
  Future<AdCreateOrUpdateModel> fetchAdDataToUpdate(int id) async {
    try {
      final response = await http.get(Uri.parse("$getAdEndpoint/$id"));

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
    // log(adData.otherImageFiles.toString());
    // return;
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
        'other_image_to_delete': jsonEncode(adData.urlsToDelete),
        'ads_image_to_delete': jsonEncode(adData.otherImgUrlsToDelete),

      };
      final url = Uri.parse('http://nic.calletic.com/api/create-ads');
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
      for (Map element in adData.otherImageFiles) {
          final filePath = (element['file'] as XFile).path;
        if(element['image_type'] == 'floor_plan'){
          try {
            request.files.add(
              await http.MultipartFile.fromPath('floor_plan', filePath),
            );
          } catch (e) {
            log('emage upload error: $e\n img: $filePath');
          }
        }else{
          try {
            request.files.add(
              await http.MultipartFile.fromPath('land_sketch', filePath),
            );
          } catch (e) {
            log('emage upload error: $e\n img: $filePath');
          }
        }
      }

      await request.send().then((streamedResponse) async {
        final response = await http.Response.fromStream(streamedResponse);
        log(response.statusCode.toString());
        log(response.body);
      });      
    } catch (e) {
      log('---------$e-----------');
    }
  }
}

class FaildToFindAdException implements Exception{}