part of 'ad_detail_bloc.dart';

abstract class AdDetailState extends Equatable {
  const AdDetailState();

  @override
  List<Object> get props => [];
}

class AdDetailInitial extends AdDetailState {}

class AdDetailsLoaded extends AdDetailState {
  final AdsModel? adsModel;
  const AdDetailsLoaded({this.adsModel});
}
