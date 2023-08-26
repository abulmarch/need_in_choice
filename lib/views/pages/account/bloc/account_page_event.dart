part of 'account_page_bloc.dart';

abstract class AccountPageEvent extends Equatable {
  const AccountPageEvent();

  @override
  List<Object> get props => [];
}

class ViewPressedEvent extends AccountPageEvent {}
class ViewNotPressedEvent extends AccountPageEvent {}

class AccountLoadingEvent extends AccountPageEvent {}

class EditingAccount extends AccountPageEvent {
  final AccountModels accountModal;

  const EditingAccount(this.accountModal);

  @override
  List<Object> get props => [accountModal];
}


class SearchEvent extends AccountPageEvent {
 final String searchText;

 final List<AdsModel> adsList;

  const SearchEvent({required this.searchText, required this.adsList});

  @override
  List<Object> get props => [searchText];
}
