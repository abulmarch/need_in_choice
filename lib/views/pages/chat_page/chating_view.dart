import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/config/theme/screen_size.dart';
import 'package:need_in_choice/services/repositories/firestore_chat_constant.dart';
import 'package:need_in_choice/views/pages/chat_page/bloc/chating_view_cubit/chating_view_cubit.dart';
import 'package:need_in_choice/views/widgets_refactored/dashed_line_generator.dart';
import '../../../services/model/ads_models.dart';
import '../../../services/model/chat_connection_model.dart';
import '../../../services/model/chat_message.dart';
import '../../../services/model/chat_user_model.dart';
import '../../../services/repositories/firestore_chat.dart';
import '../../../services/repositories/repository_urls.dart';
import '../../../services/repositories/selected_ads_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/lottie_widget.dart';
import 'bloc/chat_app_bar_ad_cubit/chat_app_bar_ad_cubit.dart';

class ChatingView extends StatefulWidget {
  const ChatingView({
    super.key,
    this.chatConn,
    this.isFirstMessage = false,
    this.chatConnectionId,
    this.user,
  });
  final ChatConnectionModel? chatConn;
  final bool isFirstMessage;
  final String? chatConnectionId;
  final ChatUser? user;

  @override
  State<ChatingView> createState() => _ChatingViewState();
}

class _ChatingViewState extends State<ChatingView> {
  ChatConnectionModel? chatConn;
  ChatUser? user;
  String? chatConnectionId;
  late final FocusNode _secondTextFieldFocus;
  @override
  void initState() {
    super.initState();
    chatConn = widget.chatConn;
    chatConnectionId = widget.chatConnectionId;
    user = widget.user;
    _secondTextFieldFocus = FocusNode();
    if( user== null) findChatUser();
  }

  findChatUser() async {
    final chattingPartnerUid = chatConn?.chattingPartnerUid();
    user = await FireStoreChat.findCurrentChatUser(chattingPartnerUid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenSize.size;
    List<ChatMessage> chatMsgList = [];
    TextEditingController textMessageController = TextEditingController();
    final height = size.height;
    final width = size.width;

    log('========================BuildContext context');
    return SafeArea(
        child: Scaffold(
            body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatAppBarAdCubit(SelectedAdsRepo()),
        ),
        BlocProvider(
          create: (context) => ChatingViewCubit()
            ..chatingViewInitial(
                chatConn: chatConn,
                chatUser: user,
                chatConnectionId: chatConnectionId,
                isFirstMessage: widget.isFirstMessage,
            ),
        ),
      ],
      child: Column(children: [
        Container(
          width: double.infinity,
          height: height * 0.18,
          margin: const EdgeInsets.only(
            top: kpadding10 / 2,
            left: kpadding10 / 2,
            right: kpadding10 / 2,
          ),
          padding: const EdgeInsets.all(kpadding10),
          decoration: BoxDecoration(
            color: kLightBlueWhite,
            borderRadius: const BorderRadius.all(
              Radius.circular(kpadding10),
            ),
            border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
          ),
          child: BlocBuilder<ChatAppBarAdCubit, ChatAppBarAdState>(
            builder: (context, state) {
              AdsModel? adsModel;
              String adPrice = '';
              if (state is ChatAppBarAdInitial) {
                return LottieWidget.loading();
              } else if (state is ChatAppBarAdLoaded) {
                adsModel = state.adsModel;
                if (adsModel != null) {
                  adPrice = adsModel.adPrice is Map
                      ? (adsModel.adPrice as Map).entries.first.value
                      : adsModel.adPrice;
                }
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                        radius: 23,
                        backgroundColor: kButtonColor,
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: kBlackColor,
                          size: 30,
                        )),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  DashedLineHeight(
                    height: size.width - 65,
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Card(
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.21,
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        '$imageUrlEndpoint/${adsModel?.images.first ?? ""}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        adsModel?.userName ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: kBlackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15), //TextStyle(color: kFadedBlack),
                      ),
                      Text(
                        // 'Modern Contrper Home ...',
                        adsModel?.adsTitle ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: kGreyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10), //TextStyle(color: kFadedBlack),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: size.width - 201,
                        child: const MySeparator(color: kDottedBorder),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      RichText(
                        text: TextSpan(
                            text: '₹ ',
                            style: const TextStyle(
                                fontSize: 18, color: kFadedBlack),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '$adPrice/-', // '9800/-',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: kFadedBlack))
                            ]),
                      ),
                    ],
                  ),
                  BlocBuilder<ChatingViewCubit, ChatingViewState>(
                    builder: (context, state) {
                      if (state is ChatingViewInitial ||
                          state is ChatingViewLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ChatConnectionNotFoundState) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (state is ChatConnectionFetchedState) {
                        chatConn = state.chatConnection;
                      }

                      return StreamBuilder(
                          stream: FireStoreChat.getCurrentChatUserInfo(
                              chatConn!.chattingPartnerUid()),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty &&
                                snapshot.data?.docs.first
                                    .data()[kUserIsOnline]) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 100),
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 18,
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 100),
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.transparent,
                                  size: 18,
                                ),
                              );
                            }
                          });
                    },
                  )
                ],
              );
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<ChatingViewCubit, ChatingViewState>(
            builder: (context, state) {
              if (state is ChatingViewInitial || state is ChatingViewLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ChatConnectionNotFoundState) {
                return const Center(child: Text('Something went wrong'));
              } else if (state is ChatConnectionFetchedState) {
                chatConn = state.chatConnection;
              }
              BlocProvider.of<ChatAppBarAdCubit>(context).fetchAdDataOfSelectedChat(adId: chatConn!.adId);
              return StreamBuilder(
                  stream: FireStoreChat.getSelectedUserChats(conversationId: chatConn!.conversationId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      chatMsgList = snapshot.data!.docs
                          .map(
                              (chatMsg) => ChatMessage.fromJson(chatMsg.data()))
                          .toList();
                      return ListView.builder(
                        itemCount: chatMsgList.length,
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          if (chatMsgList[index].read.isEmpty &&
                              chatMsgList[index].toId ==
                                  FireStoreChat.user.uid) {
                            FireStoreChat.updateMessageReadStatus(
                              message: chatMsgList[index],
                              adId: chatConn!.adId,
                            );
                          }
                          return _chatMessage(width, chatMsgList[index]);
                        },
                      );
                    } else {
                      chatMsgList = [];
                      return FutureBuilder(
                          future: Future<bool>.delayed(
                              const Duration(seconds: 1), () => true),
                          builder: (context, snapshot) {
                            String initialText = '';
                            if (snapshot.hasData && snapshot.data != null) {
                              initialText = 'Start talking business';
                            }
                            return Center(
                              child: Text(
                                initialText,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: kLightGreyColor),
                              ),
                            );
                          });
                    }
                  });
            },
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          constraints: const BoxConstraints(
            minHeight: 60,
            maxHeight: 200,
          ),
          child: TextFormField(
            controller: textMessageController,
            focusNode: _secondTextFieldFocus,
            decoration: InputDecoration(
              hintText: "Type your Message here",
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xFFF5F5F5),
                ),
              ),
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.add_chart,
                  color: Color(0XFF7B7B7B),
                ),
                onPressed: () {},
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.rocket_launch_outlined,
                      color: kWhiteColor,
                    ),
                    onPressed: () {
                      if (textMessageController.text.trim().isEmpty) return;
                      FireStoreChat.sendMessage(
                        msg: textMessageController.text,
                        chatConn: chatConn!,
                        fCMToken: user?.pushToken ?? '',
                      );
                      textMessageController.clear();
                     _secondTextFieldFocus.requestFocus();
                    },
                  ),
                ),
              ),
            ),
            minLines: 1,
            maxLines: 3,
            textInputAction: TextInputAction.newline,
          ),
        )
      ]),
    )));
  }

  Padding _chatMessage(double width, ChatMessage message) {
    bool isMe = message.fromId == FireStoreChat.user.uid;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              width: width * 0.76,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 14, bottom: 2),
              decoration: BoxDecoration(
                  color: isMe ? kPrimaryColor : const Color(0XFFeaeaea),
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10),
                    bottomRight: const Radius.circular(10),
                    topLeft: !isMe ? Radius.zero : const Radius.circular(10),
                    topRight: isMe ? Radius.zero : const Radius.circular(10),
                  ), //BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isMe
                          ? const Color(0xFF5386B6)
                          : const Color(0xffDDDDDD),
                      blurRadius: 1.0,
                      spreadRadius: 0.5,
                      offset: const Offset(0.0, 2.0),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message.msg,
                      style: TextStyle(
                        color: isMe ? Colors.white : const Color(0xff797272),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        message.sent.extractDate(),
                        style: const TextStyle(fontSize: 9),
                      ),
                      kWidth5,
                      Text(
                        message.sent.convertToTime(),
                        style: const TextStyle(fontSize: 9),
                      ),
                      if (isMe)
                        Icon(
                          message.read.isEmpty ? Icons.check : Icons.done_all,
                          size: 10,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _secondTextFieldFocus.dispose();
    super.dispose();
  }
}
