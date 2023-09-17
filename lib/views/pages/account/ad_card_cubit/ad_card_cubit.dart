import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../../../services/model/ads_models.dart';
import '../../../../services/repositories/repository_urls.dart';

part 'ad_card_state.dart';

class AdCardCubit extends Cubit<AdCardState> {
  AdCardCubit() : super(AdCardInitial());

  markAsSold(AdsModel adsData) async{
    try {
      final response = await http.post(Uri.parse(ApiEndpoints.markAsSold(adsData.id)));
      if (response.statusCode == 200) {
        final Map<String, dynamic> updatedData = jsonDecode(response.body)['result'];
        log(updatedData.toString());
        log(response.body.runtimeType.toString());
        final updatedAd = adsData.copyWith(
          expiratedDate: updatedData['ads_expiry_date'],
          adStatus: updatedData['ads_status'],
          isPremium: updatedData['is_premium'] == 1 ? true : false,
        );
        emit(AdCardDataUpdated(updatedAd: updatedAd,msg: 'Updated successfully.'));
      } else {
        emit(AdCardError());
      }
    } catch (e) {
      log('markAsSold: $e');
      emit(AdCardError());
    }
  }
  convertedToPremium(AdsModel adsData) async{
    try {
      final response = await http.post(Uri.parse(ApiEndpoints.convertedToPremium(adsData.id)));
      if (response.statusCode == 200) {
        final Map<String, dynamic> updatedData = jsonDecode(response.body)['result'];
        log(updatedData.toString());
        log(response.body.runtimeType.toString());
        final updatedAd = adsData.copyWith(
          expiratedDate: updatedData['ads_expiry_date'],
          adStatus: updatedData['ads_status'],
          isPremium: updatedData['is_premium'] == 1 ? true : false,
        );
        emit(AdCardDataUpdated(updatedAd: updatedAd, msg: 'Payment Success'));
      } else {
        emit(AdCardError());
      }
    } catch (e) {
      log('markAsSold: $e');
      emit(AdCardError());
    }
  }
}
