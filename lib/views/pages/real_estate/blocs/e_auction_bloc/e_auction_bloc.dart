import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'e_auction_event.dart';
part 'e_auction_state.dart';

class EAuctionBloc extends Bloc<EAuctionEvent, EAuctionState> {
  EAuctionBloc() : super(EAuctionInitial()) {
    on<SetDateRangeEvent>((event, emit) {
      final formattedDate = formatDate(event.selectedDate);

      if (event.bidType == BidType.bidStartDate ) {
        emit(DateSelectedState(formattedDate, event.bidType ));
      } else {
        emit(DateSelectedState(formattedDate, event.bidType));
      }
    });
  }

  String formatDate(DateTime? date) {
    if (date != null) {
      final formatter = DateFormat('MMM d');
      return formatter.format(date);
    }
    return '';
  }
}

enum BidType {
  bidStartDate, 
  bidEndDate
}