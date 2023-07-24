part of 'all_ads_bloc.dart';

abstract class AllAdsState extends Equatable {
  const AllAdsState();
  
  @override
  List<Object> get props => [];
}

class AllAdsInitial extends AllAdsState {}

class AllAdsLoding extends AllAdsState {
  final List<AdsModel> oldAdsList;

  const AllAdsLoding(this.oldAdsList);
}

class AllAdsLoaded extends AllAdsState {
  final List<AdsModel> adsList;

  const AllAdsLoaded({required this.adsList});
  @override
  List<Object> get props => [adsList];
}

//---------------------------------------------------------------
class InitialLoading extends AllAdsState{}

class NextPageLoading extends AllAdsState{
  final List<AdsModel> oldAdsList;

  const NextPageLoading(this.oldAdsList);
}