part of 'ad_card_cubit.dart';

class AdCardState extends Equatable {
  const AdCardState();

  @override
  List<Object> get props => [];
}

class AdCardInitial extends AdCardState {}
class AdCardError extends AdCardState {}

class AdCardDataUpdated extends AdCardState {
  final AdsModel updatedAd;
  final String msg;
  const AdCardDataUpdated({required this.updatedAd, required this.msg});
  @override
  List<Object> get props => [updatedAd, msg];
}
