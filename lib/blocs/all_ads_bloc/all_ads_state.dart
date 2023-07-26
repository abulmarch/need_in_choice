part of 'all_ads_bloc.dart';

abstract class AllAdsState extends Equatable {
  const AllAdsState();
  
  @override
  List<Object> get props => [];
}

class InitialLoading extends AllAdsState{}

class AllAdsLoaded extends AllAdsState {
  final List<AdsModel> adsList;

  const AllAdsLoaded({required this.adsList});
  @override
  List<Object> get props => [adsList];
}

//---------------------------------------------------------------

class NextPageLoading extends AllAdsState{
  final List<AdsModel> oldAdsList;

  const NextPageLoading(this.oldAdsList);
}