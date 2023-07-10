part of 'account_page_bloc.dart';

abstract class AccountPageState extends Equatable {
  const AccountPageState();

  @override
  List<Object> get props => [];
}

class AccountPageInitial extends AccountPageState {}
class AccountPageLoading extends AccountPageState {}

class ViewNotPressedState extends AccountPageState {}
class ViewPressedState extends AccountPageState {}




class AccountCreatingState extends AccountPageState {}

class AccountCreatedState extends AccountPageState {
  final AccountModels accountModal;

  const AccountCreatedState(this.accountModal);
  @override
  List<Object> get props => [accountModal];
}
class AccountCreatErrorState extends AccountPageState {
  final String error;

  const AccountCreatErrorState(this.error);
  @override
  List<Object> get props => [error];
}
