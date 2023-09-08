part of 'chating_view_cubit.dart';

class ChatingViewState extends Equatable {
  const ChatingViewState();

  @override
  List<Object> get props => [];
}

class ChatingViewInitial extends ChatingViewState {}

class ChatingViewLoading extends ChatingViewState {}

class ShowChatMessageState extends ChatingViewState {}

class ChatConnectionFetchedState extends ChatingViewState {
  final ChatConnectionModel chatConnection;
  const ChatConnectionFetchedState(this.chatConnection);
  @override
  List<Object> get props => [chatConnection];
}
class ChatConnectionNotFoundState extends ChatingViewState {}