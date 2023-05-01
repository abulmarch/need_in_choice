part of 'account_page_bloc.dart';

abstract class AccountPageState extends Equatable {
  const AccountPageState();
  
  @override
  List<Object> get props => [];
}

class AccountPageInitial extends AccountPageState {}

class ViewPressedState extends AccountPageState {}

