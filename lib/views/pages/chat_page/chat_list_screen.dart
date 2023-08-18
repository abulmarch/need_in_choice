import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../services/model/chat_connection_model.dart';
import '../../../services/model/chat_user_model.dart';
import '../../../services/repositories/firestore_chat.dart';
import '../../../services/repositories/repository_urls.dart' show imageUrlEndpoint;
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/lottie_widget.dart' show LottieWidget;
import '../../widgets_refactored/search_form_field.dart';
import 'chating_view.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatConnectionModel> _chatConnList = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
  log('=========:::::::::::==============');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: DefaultTabController(
            animationDuration: const Duration(milliseconds: 400),
            length: 2,
            child: Scaffold(
              body: Column(children: [
                Stack(children: [
                  Container(
                    width: double.infinity,   // constraints.maxWidth
                    height: height * 0.17,    // constraints.maxHeight
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: kpadding10 * 3,// 30
                      left: 5,
                      right: 5,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(kpadding10),
                    decoration: BoxDecoration(
                      color: kLightBlueWhite,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(kpadding10),
                      ),
                      border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
                    ),
                    child: TabBar(
                        unselectedLabelColor: kGreyColor,

                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25),),
                        color: kPrimaryColor.withOpacity(0.7),
                      ),
                      tabs: [
                        _tabButton(
                          btnName: 'Buying',
                          tabIndex: 0,
                        ),
                        _tabButton(
                          btnName: 'Selling',
                          tabIndex: 1,
                        ),
                      ],
                    )
                  ),
                  const Positioned(
                    bottom: 0,
                    left: kpadding20,
                    right: kpadding20,
                    child: SearchFormField(
                      hintText: 'Search chat Here...',
                    ),
                  ),
                ]),
                SizedBox(
                  height: height * .01,
                ),
                Expanded(
                  // child: LottieWidget.comingsoon(),
                  child: TabBarView(
                    children: [
                      _chatListStreamBuilder(height, constraints, ChatUserList.buying),
                      _chatListStreamBuilder(height, constraints, ChatUserList.selling),
                    ],
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _chatListStreamBuilder(double height, BoxConstraints constraints, ChatUserList userListType) {
    return StreamBuilder(
      stream: FireStoreChat.getChatConnectionsOfCurrentUser(userListType),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
          _chatConnList = snapshot.data!.docs.map((querySnap) => ChatConnectionModel.fromJson(querySnap.data())).toList();
          return StreamBuilder(
            stream: FireStoreChat.filterUsersFromChar(_chatConnList),
            builder: (context, snapshot) {
              List<ChatUser> usersList = [];
              if (snapshot.hasData) {
                usersList = snapshot.data!.docs.map((data) => ChatUser.fromJson(data.data())).toList();
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _chatConnList.length,
                itemBuilder: (context, index) {
                  String chattingPartnerUid = _chatConnList[index].chattingPartnerUid();
                  return _chatCard(
                    height: height, 
                    context: context, 
                    constraints: constraints,
                    chatConn: _chatConnList[index],
                    isuserOnline: usersList.any((element) => element.uid == chattingPartnerUid ? element.isOnline : false),
                  );
                }
              );
            }
          );
        }else{
          _chatConnList =[];
          return FutureBuilder(
            future: Future<bool>.delayed(const Duration(seconds: 1),() => true),
            builder: (context, snapshot) {
              String initialText = '';
              if (snapshot.hasData && snapshot.data != null) {
                initialText = 'No chat available';
              }
              return Center(
                child: Text(initialText,style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: kLightGreyColor),),
              );
            }
          );
        }
      }
    );
  }

  Tab _tabButton({required String btnName, required int tabIndex,}) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(btnName,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 15),
        ),
      ),
    );
  }

  Column _chatCard({
    required double height, 
    required BuildContext context, 
    required BoxConstraints constraints,
    required ChatConnectionModel chatConn,
    required bool isuserOnline,
  }) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.095,
          child: Column(children: [
            SizedBox(
              height: height * 0.001,
            ),
            Row(
              children: [
                kWidth10,
                Card(
                  child: Container(
                    height: height * 0.08,
                    width: 60,
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                        '$imageUrlEndpoint/${chatConn.adsImage}',
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
                kWidth10,
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute( builder: (context) => ChatingView(chatConn: chatConn,)));
                  },
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anjitha',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                color: kBlackColor,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    15), //TextStyle(color: kFadedBlack),
                      ),
                      Text(
                        chatConn.adTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                color: kGreyColor,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    12), //TextStyle(color: kFadedBlack),
                        overflow: TextOverflow.ellipsis,
                      ),
                      DashedLineGenerator(
                        width: constraints.maxWidth - 200,
                      ),
                      Text(
                        'we agreed on Rs 353453',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    9), //TextStyle(color: kFadedBlack),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _show(context);
                      },
                      child: Image.asset('assets/images/icons/Burger.png')
                    ),
                    kHeight10,
                    Icon(Icons.circle,size: 15,color: isuserOnline ? kGreenColor : Colors.transparent,)
                  ],
                )
              ],
            )
          ]),
        ),
        const SizedBox(
          height: 2,
        ),
        DashedLineGenerator(
          width: constraints.maxWidth - 65,
        ),
        kHeight5
      ],
    );
  }

  void _show(BuildContext ctx) {
    final double height = MediaQuery.of(ctx).size.height;
    final double width = MediaQuery.of(ctx).size.width;

    showModalBottomSheet(
      elevation: 10,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width * .5,
          height: height * .28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Remove &',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: kDarkGreyColor),
                  children: [
                    TextSpan(
                      text: ' Delete\n',
                      style: Theme.of(ctx)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: kButtonRedColor),
                    ),
                    TextSpan(
                      text: 'Chat Now',
                      style: Theme.of(ctx)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: kButtonRedColor),
                    ),
                    TextSpan(
                      text: '...',
                      style: Theme.of(ctx)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: kDarkGreyColor),
                    ),
                  ],
                ),
              ),
              DashedLineGenerator(
                width: width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width / 2.5,
                      height: height * .06,
                      decoration: BoxDecoration(
                          color: kButtonRedColor,
                          border: Border.all(color: kButtonRedColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Center(
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .05,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: width / 2.5,
                      height: height * .06,
                      decoration: BoxDecoration(
                          border: Border.all(color: kButtonColor),
                          color: kButtonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: const Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: kGreyColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
