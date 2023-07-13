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
