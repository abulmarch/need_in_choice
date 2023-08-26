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

    on<SearchEvent>(_updateFilteredAds);
  }

  FutureOr<void> _loadAccountdata(AccountLoadingEvent event, Emitter<AccountPageState> emit) async {
    emit(AccountPageLoading());
    try {
      final accountdata = AccountSingleton().getAccountModels;
      final adData = await _adsRepo.getUserAds(accountdata.userId!);
      emit(AccountDataLoaded(accountdata, adData));
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
      if (accountUpdated) {
        AccountSingleton().setAccountModels = event.accountModal;
        emit(AccountEditedState(event.accountModal));
      } else {
        AccountEditErrorState(e.toString());
      }
    } catch (e) {
      emit(AccountEditErrorState(e.toString()));
    }
  }
}

void _updateFilteredAds(SearchEvent event, Emitter<AccountPageState> emit) {
  emit(AccountEditingState());
  try {
    final filter = event.searchText.toLowerCase();
    final filteredAdsData = event.adsList.where((ad) {
      return ad.adsTitle.toLowerCase().contains(filter);
    }).toList();
    emit(SearchLoadedState(filteredAdsData));
  } catch (e) {
    print(e);
  }
}
