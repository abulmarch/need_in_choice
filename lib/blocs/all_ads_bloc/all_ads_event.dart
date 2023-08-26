part of 'all_ads_bloc.dart';

abstract class AllAdsEvent extends Equatable {
  const AllAdsEvent();

  @override
  List<Object> get props => [];
}


class FetchAllAds extends AllAdsEvent{
  final AdsFetchingType typeOfFetching;
  const FetchAllAds({
    required this.typeOfFetching,
  });
}

class FetchNextPage extends AllAdsEvent{}

class SearchAllAds extends AllAdsEvent{
  final AdsFetchingType typeOfFetching;
  final String searchingWord;
  const SearchAllAds({
    required this.typeOfFetching,
    required this.searchingWord,
  });
}

class SortAdsByCategory extends AllAdsEvent{
  final String? categoryEndRoute;
  final MainCategory? selectedMainCat;
  final AdsFetchingType typeOfFetching;
  const SortAdsByCategory({
    this.categoryEndRoute,
    this.selectedMainCat,
    required this.typeOfFetching,
  });
}

class BackToFetchAllAds extends AllAdsEvent{}

class RefreshPageAndFetchAds extends AllAdsEvent{}

