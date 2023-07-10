part of 'account_page_bloc.dart';

abstract class AccountPageEvent extends Equatable {
  const AccountPageEvent();

  @override
  List<Object> get props => [];
}

class ViewPressedEvent extends AccountPageEvent {}

class CreateAccount extends AccountPageEvent {
  final AccountModels accountModal;

  const CreateAccount(this.accountModal);

  @override
  List<Object> get props => [accountModal];
}
