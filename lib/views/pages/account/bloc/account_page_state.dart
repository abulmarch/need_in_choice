part of 'account_page_bloc.dart';

abstract class AccountPageState extends Equatable {
  const AccountPageState();

  @override
  List<Object> get props => [];
}

class AccountPageInitial extends AccountPageState {}

class AccountPageLoading extends AccountPageState {}

class AccountDataLoaded extends AccountPageState {
  final AccountModels accountModels;
  final List<AdsModel> adsModelList;

  const AccountDataLoaded(this.accountModels, this.adsModelList);
  @override
  List<Object> get props => [accountModels];
}

class AccountDataError extends AccountPageState {
  final String error;

  const AccountDataError(this.error);
  @override
  List<Object> get props => [error];
}

class ViewNotPressedState extends AccountPageState {}

class ViewPressedState extends AccountPageState {}

class AccountEditingState extends AccountPageState {}

class AccountEditedState extends AccountPageState {
  final AccountModels accountModal;

  const AccountEditedState(this.accountModal);
  @override
  List<Object> get props => [accountModal];
}

class AccountEditErrorState extends AccountPageState {
  final String error;

  const AccountEditErrorState(this.error);
  @override
  List<Object> get props => [error];
}
