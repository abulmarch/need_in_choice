part of 'all_ads_bloc.dart';

abstract class AllAdsEvent extends Equatable {
  const AllAdsEvent();

  @override
  List<Object> get props => [];
}


class FetchAllAds extends AllAdsEvent{
  final bool isFirstFetch;
  const FetchAllAds({
    this.isFirstFetch = false,
  });
}

class SearchAllAds extends AllAdsEvent{
  final bool isFirstFetch;
  const SearchAllAds({
    this.isFirstFetch = false,
  });
}
class SortAdsByCategory extends AllAdsEvent{
  final MainCategory? category;
  final bool isFirstFetch;
  const SortAdsByCategory({
    this.isFirstFetch = false,
    this.category
  });
}
