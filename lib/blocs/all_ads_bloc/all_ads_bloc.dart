import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/model/account_model.dart';
import '../../services/model/ads_models.dart';
import '../../services/repositories/all_ads_services.dart';
import '../../services/repositories/repository_urls.dart' show ApiEndpoints;
import '../../utils/category_data.dart';
import '../../utils/main_cat_enum.dart';

part 'all_ads_event.dart';
part 'all_ads_state.dart';

class AllAdsBloc extends Bloc<AllAdsEvent, AllAdsState> {
  final AllAdsRepo allAdsRepo;
  int _page = 1;
  int _cachOfAllAdsLastPage = 0;
  List<AdsModel> _cachedAdsData = [];
  List<AdsModel> _previousList = [];
  AdsFetchingType _fetchingType = AdsFetchingType.fetchAllAds;
  String? _serchingWord;

  String? _routeForSorting;
  MainCategory? _selectedMainCatForSort;

  AllAdsBloc(this.allAdsRepo) : super(InitialLoading()) {

    on<FetchAllAds>(_fetchAllAds);
    on<SortAdsByCategory>(_sortAdsByCategory);
    on<SearchAllAds>(_searchingAd);

    on<FetchNextPage>(_fetchNextPage);
    
    on<BackToFetchAllAds>(_backToFetchAllAds);
    on<RefreshPageAndFetchAds>(_refreshPage);
  
  }

  FutureOr<void> _fetchAllAds(FetchAllAds event, Emitter<AllAdsState> emit) async {
    _fetchingType = event.typeOfFetching;
    final pincode = AccountSingleton().getAccountModels.placePincode;
    await _loadAndEmitAds(emit, ApiEndpoints.getAdsUrl(_page, pincode?? ''));
  }

  FutureOr<void> _sortAdsByCategory(SortAdsByCategory event, Emitter<AllAdsState> emit) async {
      emit(InitialLoading());
      if(_cachedAdsData.isEmpty){// save allready fetched 'all ads' data and its loaded pages
        _cachedAdsData = _previousList;
        _cachOfAllAdsLastPage = _page;
      }
      _fetchingType = event.typeOfFetching;
      _page = 1;
      _previousList = [];
      _routeForSorting = event.categoryEndRoute;
      _selectedMainCatForSort = event.selectedMainCat;
      final pincode = AccountSingleton().getAccountModels.placePincode;
    await _loadAndEmitAds(emit, ApiEndpoints.sortAdsUrl(_routeForSorting, pincode??'',_page));
  }

  FutureOr<void> _searchingAd(SearchAllAds event, Emitter<AllAdsState> emit) async {
    emit(InitialLoading());
    if(_cachedAdsData.isEmpty){// save allready fetched 'all ads' data and its loaded pages
      _cachedAdsData = _previousList;
      _cachOfAllAdsLastPage = _page;
    }
    _fetchingType = event.typeOfFetching;
    _page = 1;
    _previousList = [];
    _serchingWord = event.searchingWord;
    final pincode = AccountSingleton().getAccountModels.placePincode;
    await _loadAndEmitAds(emit, ApiEndpoints.searchAdsUrl(_serchingWord??'', pincode??'',_page));
  }

  Future<FutureOr<void>> _fetchNextPage(FetchNextPage event, Emitter<AllAdsState> emit) async {
    emit(NextPageLoading(_previousList));
    log('*************************');
    final pincode = AccountSingleton().getAccountModels.placePincode;
    String url = _fetchingType == AdsFetchingType.fetchAllAds 
        ? ApiEndpoints.getAdsUrl(_page, pincode?? '')
        : _fetchingType == AdsFetchingType.fetchSortedAds 
        ? ApiEndpoints.sortAdsUrl(_routeForSorting, pincode??'',_page)
        : ApiEndpoints.searchAdsUrl(_serchingWord??'', pincode??'',_page);
    await _loadAndEmitAds(emit, url);
  }

  
  Future<FutureOr<void>> _loadAndEmitAds(Emitter<AllAdsState> emit, String url) async {
    log(url);
    final adsList = await allAdsRepo.fetchAllAdsData(url);
    adsList.forEach((element) {
      log(element.toString());
    });
    _previousList.addAll(adsList);
    emit(AllAdsLoaded(adsList: _previousList));
    if(_page <= AllAdsRepo.lastPage +1){// if AllAdsRepo.lastPage = 5 then _page value can upto 6
        _page++;
    }
  }

  FutureOr<void> _backToFetchAllAds(BackToFetchAllAds event, Emitter<AllAdsState> emit) {
    emit(InitialLoading());
    _previousList = _cachedAdsData;
    _page = _cachOfAllAdsLastPage;
    _cachedAdsData = [];
    _cachOfAllAdsLastPage = 0;
    _routeForSorting = null;
    _selectedMainCatForSort = null;
    _fetchingType = AdsFetchingType.fetchAllAds;
    emit(AllAdsLoaded(adsList: _previousList,backToFetchAllAdsEvent: true));
  }

  FutureOr<void> _refreshPage(RefreshPageAndFetchAds event, Emitter<AllAdsState> emit) async{
    emit(InitialLoading());
    _page = 1;
    _previousList = [];
    final pincode = AccountSingleton().getAccountModels.placePincode;
    String url = _fetchingType == AdsFetchingType.fetchAllAds 
        ? ApiEndpoints.getAdsUrl(_page, pincode?? '')
        : _fetchingType == AdsFetchingType.fetchSortedAds 
        ? ApiEndpoints.sortAdsUrl(_routeForSorting, pincode??'',_page)
        : ApiEndpoints.searchAdsUrl(_serchingWord??'', pincode??'',_page);
    await _loadAndEmitAds(emit, url);
  }

  bool get isDataCached => _cachedAdsData.isNotEmpty; // it return true if it is searching state

  int get indexOfMainCatForSort =>
       _selectedMainCatForSort == null ? -1 
       : mainCategories.indexWhere((cat) => cat['MainCategory'] == _selectedMainCatForSort);

  AdsFetchingType get fetchingType=> _fetchingType;
  
}


enum AdsFetchingType{
  fetchAllAds,
  fetchSortedAds,
  fetchSearchedAds
}