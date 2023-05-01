import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  bool _isViewing = false;
   bool _isViewButton = true;
  AccountPageBloc() : super(AccountPageInitial()) {
    on<ViewPressedEvent>((event, emit) {
      if (_isViewing) {
        _isViewing = false;
        _isViewButton = true;
        emit(AccountPageInitial());
      } else {
        _isViewing = true;
        _isViewButton = false;
        emit(ViewPressedState());
      }
    });
  }
  bool get isViewButton => _isViewButton;
}
