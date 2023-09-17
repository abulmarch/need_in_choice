import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/repositories/firestore_chat.dart';
import 'package:need_in_choice/utils/colors.dart';

import '../../../../blocs/bottom_navigation_cubit/bottom_navigation_cubit.dart';
import '../../../../services/model/chat_connection_model.dart';


class MessageCount {
  static ValueNotifier<bool> mesgCount = ValueNotifier(true);
} 
class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        final currentIndex = state.props.first as int;
        return BottomNavigationBar(
          iconSize: 30,
          elevation: 20,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          onTap: (value) {
            BlocProvider.of<BottomNavigationCubit>(context).changeTab(value);
          },
          currentIndex: currentIndex,
          items: [
            const BottomNavigationBarItem(label: 'Home',icon: Icon(Icons.home_outlined),activeIcon: Icon(Icons.home),),
            BottomNavigationBarItem(
              label: 'Chat',
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.sms_outlined),
                  StreamBuilder(
                    stream: FireStoreChat.getAllChatConn(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // final conversationIdList = snapshot.data!.map((chatConn) => chatConn.conversationId).toList();
                        final conversationIdList = snapshot.data!.docs.map((chatCon) => ChatConnectionModel.fromJson(chatCon.data(), chatCon.id)).toList();
                        return ValueListenableBuilder<bool>(
                          valueListenable: MessageCount.mesgCount,
                          builder: (context,boolVal, _) {
                            return FutureBuilder(
                              future: FireStoreChat.isThereNewMessage(conversationIdList),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  log(snapshot.data.toString());
                                  final count = snapshot.data ?? 0;
                                  return count > 0 ? unreadMessageDotmark() : const SizedBox();
                                }
                                return const SizedBox();
                              }
                            );
                          }
                        );                        
                      }else{
                        return const SizedBox();
                      }
                    }
                  )
                ]
              ),
              activeIcon: const Icon(Icons.sms_outlined),
            )
          ],
        );
      }
    );
  }

  Positioned unreadMessageDotmark() {
    return const Positioned(
      top: -3,
      right: -3,
      child: Icon(Icons.brightness_1, size: 15, 
        color: kPrimaryColor),
    );
  }
}