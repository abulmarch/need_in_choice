import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/chat_user_model.dart';

import '../../../../../services/model/chat_connection_model.dart';
import '../../../../../services/repositories/firestore_chat.dart';

part 'chating_view_state.dart';

class ChatingViewCubit extends Cubit<ChatingViewState> {
  ChatingViewCubit() : super(ChatingViewInitial());
  Future chatingViewInitial({
    required ChatConnectionModel? chatConn,
    required bool isFirstMessage,
    required String? chatConnectionId,
    ChatUser? chatUser
  }) async {
    if (chatConn != null) {
      // sending first message if it is new connection
      if (isFirstMessage) {
        FireStoreChat.sendMessage(
          msg: 'Hai, I am interested in this ad. Can you share me more details?',
          fCMToken: chatUser?.pushToken??'',
          chatConn: chatConn
        );
      }
      emit(ShowChatMessageState());
    } else {
      log('chatConnectionId:   $chatConnectionId');
      final chatConnection =
          await FireStoreChat.getChatConnectionFromId(chatConnectionId ?? '');
      if (chatConnection != null) {
        emit(ChatConnectionFetchedState(chatConnection));
      } else {
        emit(ChatConnectionNotFoundState());
      }
    }
  }
}
