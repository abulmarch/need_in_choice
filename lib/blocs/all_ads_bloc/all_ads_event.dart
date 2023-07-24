part of 'all_ads_bloc.dart';

abstract class AllAdsEvent extends Equatable {
  const AllAdsEvent();

  @override
  List<Object> get props => [];
}

class GetAllAdsFirstFetch extends AllAdsEvent {}

class FetchNextPageAds extends AllAdsEvent {
  final List<AdsModel> oldAdsList;

  const FetchNextPageAds({required this.oldAdsList});
}
class FetchAllAds extends AllAdsEvent{
  final List<AdsModel> oldAdsList;
  final bool isFirstFetch;
  const FetchAllAds({
    required this.oldAdsList,
    this.isFirstFetch = false,
  });
}
class SearchAllAds extends AllAdsEvent{
  final List<AdsModel> oldAdsList;
  final bool isFirstFetch;
  const SearchAllAds({
    required this.oldAdsList,
    this.isFirstFetch = false,
  });
}
