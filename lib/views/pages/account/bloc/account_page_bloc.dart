import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/repositories/auth_repo.dart';

import '../../../../services/model/account_model.dart';


part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  final Authrepo authrepo;
  bool _isViewing = false;
  bool _isViewButton = true;
  AccountPageBloc(this.authrepo) : super(AccountPageInitial()) {
    on<ViewPressedEvent>((event, emit) {
      if (_isViewing) {
        _isViewing = false;
        _isViewButton = true;
        emit(ViewPressedState());
      } else {
        _isViewing = true;
        _isViewButton = false;
        emit(ViewNotPressedState());
      }
    });
    on<CreateAccount>((event, emit) async {
      emit(AccountCreatingState());
      try {
        final newAccount =
            await authrepo.createAccount(postData: event.accountModal);
        emit(AccountCreatedState(newAccount));
      } catch (e) {
        emit(AccountCreatErrorState(e.toString()));
      }
    });
  }

  bool get isViewButton => _isViewButton;
}
