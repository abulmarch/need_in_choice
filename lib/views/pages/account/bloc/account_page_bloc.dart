import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/services/repositories/auth_repo.dart';

import '../../../../services/model/account_model.dart';
import '../../../../services/repositories/user_ads_repo.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  final Authrepo authrepo;
  final UserAdsRepo _adsRepo = UserAdsRepo();

  AccountPageBloc(this.authrepo) : super(AccountPageLoading()) {
    on<AccountLoadingEvent>(_loadAccountdata);

    on<EditingAccount>(_editAccount);

    on<ViewPressedEvent>((event, emit) {
      emit(ViewPressedState());
    });

    on<ViewNotPressedEvent>((event, emit) {
      emit(ViewNotPressedState());
    });
  }

  FutureOr<void> _loadAccountdata(
      AccountLoadingEvent event, Emitter<AccountPageState> emit) async {
    emit(AccountPageLoading());
    try {
      final uid = authrepo.firebaseAuth.currentUser!.uid;
      final accountdata = await authrepo.fetchAccountsData(uid);
      final adData = await _adsRepo.getUserAds(uid);
      emit(AccountDataLoaded(accountdata!, adData));
    } catch (e) {
      emit(AccountDataError(e.toString()));
    }
  }

  FutureOr<void> _editAccount(
      EditingAccount event, Emitter<AccountPageState> emit) async {
    emit(AccountEditingState());
    try {
      bool accountUpdated =
          await authrepo.updateAccount(postData: event.accountModal);
      accountUpdated
          ? emit(AccountEditedState(event.accountModal))
          : AccountEditErrorState(e.toString());
    } catch (e) {
      emit(AccountEditErrorState(e.toString()));
    }
  }
}
