part of 'ad_detail_bloc.dart';

abstract class AdDetailBlocEvent extends Equatable {
  const AdDetailBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchAdDetailEvent extends AdDetailBlocEvent {
  final int adId;

  const FetchAdDetailEvent({required this.adId});

  @override
  List<Object> get props => [adId];
}
