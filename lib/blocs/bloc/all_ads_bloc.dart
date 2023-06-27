import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/model/ads_models.dart';
import '../../services/repositories/all_ads_services.dart';

part 'all_ads_event.dart';
part 'all_ads_state.dart';

class AllAdsBloc extends Bloc<AllAdsEvent, AllAdsState> {
  final AllAdsRepo allAdsRepo;
  int _page = 1;
  AllAdsBloc(this.allAdsRepo) : super(AllAdsInitial()) {
    on<GetAllAdsFirstFetch>(_onLoadAllAds);

    on<FetchNextPageAds>(_fetchNextPageAds);
  }
  void _onLoadAllAds(GetAllAdsFirstFetch event, Emitter<AllAdsState> emit) async{
    emit(AllAdsInitial());
    final adsList = await allAdsRepo.fetchAllAdsData(_page);
    emit(AllAdsLoaded(adsList: adsList));
    if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page can upto 6
        _page++;
    }
    print('----_page--------->   $_page');
  }
  Future<void> _fetchNextPageAds(FetchNextPageAds event, Emitter<AllAdsState> emit) async {
    final oldList = event.oldAdsList;
    emit(AllAdsLoding(oldList));
    final adsList = await allAdsRepo.fetchAllAdsData(_page);
    oldList.addAll(adsList);
    emit(AllAdsLoaded(adsList: oldList));
    if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page can upto 6
        _page++;
    }
    print('-----------_page-->\\\\   $_page');
  }
}
