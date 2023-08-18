part of 'chat_app_bar_ad_cubit.dart';

class ChatAppBarAdState extends Equatable {
  const ChatAppBarAdState();

  @override
  List<Object> get props => [];
}

class ChatAppBarAdInitial extends ChatAppBarAdState {}

class ChatAppBarAdLoaded extends ChatAppBarAdState {
  final AdsModel? adsModel;

  const ChatAppBarAdLoaded(this.adsModel);
}