part of 'e_auction_bloc.dart';

class EAuctionEvent extends Equatable {
  const EAuctionEvent();

  @override
  List<Object> get props => [];
}

class SetDateRangeEvent extends EAuctionEvent {
  final DateTime selectedDate;
  final BidType bidType;

  const SetDateRangeEvent({required this.selectedDate, required this.bidType});

  @override
  List<Object> get props => [selectedDate, bidType];
}
