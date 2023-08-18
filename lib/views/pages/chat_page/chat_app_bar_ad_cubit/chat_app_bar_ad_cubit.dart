import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../services/model/ads_models.dart';
import '../../../../services/repositories/selected_ads_service.dart';

part 'chat_app_bar_ad_state.dart';

class ChatAppBarAdCubit extends Cubit<ChatAppBarAdState> {
  final SelectedAdsRepo repo;
  ChatAppBarAdCubit(this.repo) : super(ChatAppBarAdInitial());

  Future<void> fetchAdDataOfSelectedChat({required int adId}) async{
    final adsModel = await repo.fetchSelectedAdsData(adId);
      emit(ChatAppBarAdLoaded(adsModel));
  }
}
