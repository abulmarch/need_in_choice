import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/model/ads_models.dart';
import '../../services/repositories/all_ads_services.dart';
import '../../utils/main_cat_enum.dart';

part 'all_ads_event.dart';
part 'all_ads_state.dart';

class AllAdsBloc extends Bloc<AllAdsEvent, AllAdsState> {
  final AllAdsRepo allAdsRepo;
  int _page = 1;
  List<AdsModel>? _cachedAdsData;
  List<AdsModel> _previousList = [];

  MainCategory _selectedMainCategoryToSortAd = MainCategory.realestate;

  AllAdsBloc(this.allAdsRepo) : super(InitialLoading()) {

    on<FetchAllAds>(_fetchAllAds);
    on<SortAdsByCategory>(_sortAdsByCategory);
  
  }
  // FutureOr<void> _fetchAllAds(FetchAllAds event, Emitter<AllAdsState> emit) async {
  //   late final List<AdsModel> oldList;
  //   if(event.isFirstFetch) {
  //     oldList = [];
  //   }else{
  //     oldList = event.oldAdsList;
  //     emit(NextPageLoading(oldList));
  //   }
  //   final adsList = await allAdsRepo.fetchAllAdsData(_page);
  //   oldList.addAll(adsList);
  //   emit(AllAdsLoaded(adsList: oldList));
  //   if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page value can upto 6
  //       _page++;
  //   }
  // }
  FutureOr<void> _fetchAllAds(FetchAllAds event, Emitter<AllAdsState> emit) async {
    if(!event.isFirstFetch) {
      emit(NextPageLoading(_previousList));
    }
    final adsList = await allAdsRepo.fetchAllAdsData(_page);
    _previousList.addAll(adsList);
    emit(AllAdsLoaded(adsList: _previousList));
    if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page value can upto 6
        _page++;
    }
  }

  FutureOr<void> _sortAdsByCategory(SortAdsByCategory event, Emitter<AllAdsState> emit) async {
    if(event.isFirstFetch) {
      emit(InitialLoading());
      _previousList = [];
      _selectedMainCategoryToSortAd = event.category ?? MainCategory.realestate;
    }else{
      emit(NextPageLoading(_previousList));
    }
    final adsList = await allAdsRepo.fetchAllAdsData(_page);
    _previousList.addAll(adsList);
    emit(AllAdsLoaded(adsList: _previousList));
    if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page value can upto 6
        _page++;
    }
  }
}
