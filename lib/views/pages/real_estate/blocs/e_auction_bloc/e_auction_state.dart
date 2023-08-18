part of 'e_auction_bloc.dart';

class EAuctionState extends Equatable {
  const EAuctionState();

  @override
  List<Object> get props => [];
}

class EAuctionInitial extends EAuctionState {}

class DateSelectedState extends EAuctionState {
  final String date;
  final BidType bidType;

  const DateSelectedState(
    this.date, this.bidType,
  );

  @override
  List<Object> get props => [date];
}
