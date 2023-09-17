import 'dart:developer';
import 'dart:convert' show jsonEncode;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http show post;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/account_model.dart';
import '../model/ads_models.dart';
import '../model/chat_connection_model.dart';
import '../model/chat_message.dart';
import '../model/chat_user_model.dart';
import 'firestore_chat_constant.dart';
import 'key_information.dart';

class FireStoreChat {
  static FirebaseFirestore? firestoreInstance;
  static User? userData;

  static FirebaseFirestore get firestore => firestoreInstance!;
  static User get user => userData!;

  static init(){
    FireStoreChat.firestoreInstance = FirebaseFirestore.instance;
    FireStoreChat.userData = FirebaseAuth.instance.currentUser!;
  }
  static dispose(){
    FireStoreChat.firestoreInstance = null;
    FireStoreChat.userData = null;
  }
  static clearFirestoreInstance() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {
      log('FirebaseFirestore.instance.clearPersistence : $e');
    }
  }

  Future<void> createChatUser({
    required String uid,
  }) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Map<String, dynamic> chatUser = {
      'id': 'id',
      'name': 'my_name',
      'is_online': false,
      'last_active': time,
      'created_at': time,
    };
    await firestore.collection('users').doc(uid).set(chatUser);
  }

  static Future<ChatConnectionModel?> checkChatAllreadyGenerated({
    required String creatorId,
    required int selectedAdId,
  }) async {
    try {
      final value = await firestore
          .collection(kTableChatConnection)
          .where(kAdId, isEqualTo: selectedAdId)
          .where(kConnectionGenUid, isEqualTo: user.uid)
          .where(kAdCreatorUid, isEqualTo: creatorId)
          .get();
      if (value.docs.isNotEmpty) {
        return ChatConnectionModel.fromJson(
            value.docs.first.data(), value.docs.first.id);
      } else {
        return null;
      }
    } catch (error) {
      log('ERROR: checkChatAllreadyGenerated()  $error');
      return null;
    }
  }

  static Future<ChatConnectionModel?> generateNewChat({
    required AdsModel adsModel,
  }) async {
    try {
      final docPathTime = DateTime.now().microsecondsSinceEpoch.toString();
      final generatedTime = DateTime.now().millisecondsSinceEpoch.toString();
      final conn = ChatConnectionModel(
        adId: adsModel.id,
        adCreatorUid: adsModel.userId,
        adsImage: adsModel.images.isNotEmpty? adsModel.images.first: '',
        adTitle: adsModel.adsTitle,
        connectionGenUid: user.uid,
        connectionGenTime: generatedTime,
        isChatDeleted: false,
        conversationId: getConversationID(chatingPartnerUid: adsModel.userId, adId: adsModel.id)
      );
      log("conn.toJson() : ${conn.toJson()}");
      await firestore
          .collection(kTableChatConnection)
          .doc(docPathTime)
          .set(conn.toJson());
      return conn;
    } catch (e) {
      log('-----generateNewChat(): $e --------------');
      return null;
    }
  }

  static Future<void> deleteChatConnection({
    required ChatConnectionModel chatConn,
  }) async {
    try {
      await firestore
          .collection(kTableChatConnection)
          .doc(chatConn.connectionDocId)
          .update({kIsChatDeleted: true});
    } catch (e) {
      log('========  e deleteChatConnection() : $e  ');
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getChatConnectionsOfCurrentUser(ChatUserList userListType) {
    final idType =
        userListType == ChatUserList.buying ? kConnectionGenUid : kAdCreatorUid;
    return firestore
        .collection(kTableChatConnection)
        .where(idType, isEqualTo: user.uid)
        .where(kIsChatDeleted, isEqualTo: false)
        .snapshots();
  }

  static Future<ChatConnectionModel?> getChatConnectionFromId(String chatConnectionId) async {
    try {
      final chatConnectiondata = await firestore
          .collection(kTableChatConnection)
          .doc(chatConnectionId)
          .get();
      if (chatConnectiondata.data()?.isNotEmpty ?? false) {
        log(chatConnectiondata.data().toString());
        final chatConnectionModel = ChatConnectionModel.fromJson(
            chatConnectiondata.data()!, chatConnectionId);
        return chatConnectionModel;
      }
      return null;
    } catch (e) {
      log('getChatConnectionFromId: $e');
      return null;
    }
  }

  static Future<void> sendMessage({
    required String msg,
    Type type = Type.text,
    required String fCMToken,
    required ChatConnectionModel chatConn,
  }) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final ChatMessage message = ChatMessage(
        toId: chatConn.chattingPartnerUid(),
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: ChatTime(time));

    final ref = firestore
        .collection('$kTableChats/${chatConn.conversationId}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        FireStoreChat.sendMessageNotification(fcmToken: fCMToken, chatConnId: chatConn.connectionDocId??''));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSelectedUserChats({
    required String conversationId,
    // required int adId,
  }) {
    return firestore
        .collection(
            '$kTableChats/$conversationId/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserLastChatMessage({
    required String receiverUid,
    required int adId,
  }) {
    return firestore
        .collection(
            '$kTableChats/${getConversationID(chatingPartnerUid:receiverUid, adId:adId)}/messages/')
        .orderBy(kChatSent, descending: true)
        .limit(1)
        .snapshots();
  }

  static Future<int> getUserUnreadChatCount({
    required String receiverUid,
    required int adId,
  }) async {
    try {
      final countQuery = await firestore
          .collection(
              '$kTableChats/${getConversationID(chatingPartnerUid: receiverUid,adId: adId)}/messages/')
          .where(kChatRead, isEqualTo: '')
          .where(kChatToId, isEqualTo: user.uid)
          .count()
          .get();
      return countQuery.count;
    } catch (e) {
      log('getUserUnreadChatCount:   $e');
      return 0;
    }
  }

  // static Future<List<ChatConnectionModel>> getAllChatConn() async {
  //   try {
  //     final result = await firestore.collection(kTableChatConnection)
  //     .where(kConversationId, isGreaterThanOrEqualTo: user.uid).get();
  //       final chatConnList = result.docs.map((chatCon) => ChatConnectionModel.fromJson(chatCon.data(), chatCon.id)).toList();
  //       return chatConnList;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatConn(){
    return firestore.collection(kTableChatConnection)
    .where(kConversationId, isGreaterThanOrEqualTo: user.uid)
    .snapshots();
  }

  static Future<int> isThereNewMessage(List<ChatConnectionModel> chatConn) async{
    int num = 0;
    for (var conn in chatConn) {
      final count = await firestore.collection('$kTableChats/${conn.conversationId}/messages').where(kChatRead,isEqualTo: '').where(kChatToId, isEqualTo: user.uid).count().get();
      num = num + count.count;
    }
    return num;
  }

  // for creating a new user
  static Future<void> createUser() async {
    log('===============${user.uid}==== createUser ');
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final token = await FirebaseMessaging.instance.getToken();
    String nammme = '';
    try {
      nammme = AccountSingleton().getAccountModels.name ?? '';
    } catch (e) {
      log('-------****--------**** $e');
    }
    final chatUser = ChatUser(
        uid: user.uid,
        name: nammme,
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: true,
        lastActive: time,
        pushToken: token ?? '');
    log('-------------------------------->>>>');
    return await firestore
        .collection(kTableUsers)
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> filterUsersFromChar(
      List<ChatConnectionModel> chatConnList) {
    List<String> uidList =
        chatConnList.map((chatuser) => chatuser.chattingPartnerUid()).toList();
    return firestore
        .collection(kTableUsers)
        .where(kUserUid,
            whereIn: uidList.isEmpty
                ? ['']
                : uidList) //because empty list throws an error
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentChatUserInfo(
      String uid) {
    return firestore
        .collection(kTableUsers)
        .where(kUserUid, isEqualTo: uid)
        .snapshots();
  }

  static Future<ChatUser?> findCurrentChatUser(String uid) async {
    try {
      final snapshotData = await firestore
          .collection(kTableUsers)
          .where(kUserUid, isEqualTo: uid)
          .get();
      final chatUser = ChatUser.fromJson(snapshotData.docs.first.data());
      return chatUser;
    } catch (e) {
      log('getCurrentChatUserInfoo: $e');
      return null;
    }
  }

  static Future<void> updateTokenInDatabase(String token) async {
    firestore.collection(kTableUsers).doc(user.uid).update({
      kUserPushToken: token,
    });
  }

  static Future<void> updateUserActiveStatus(bool isOnline) async {
    try {
      log('======> ${user.uid} ');
      firestore.collection(kTableUsers).doc(user.uid).update({
        kUserIsOnline: isOnline,
        kUserLastActive: DateTime.now().millisecondsSinceEpoch.toString(),
      }).onError((error, stackTrace) => log("updateUserActiveStatus errroer: $error"));
    } catch (e) {
      log('updateUserActiveStatus: $e');
    }
  }

  static Future<void> updateMessageReadStatus(
      {required ChatMessage message, required int adId}) async {
    firestore.collection('$kTableChats/${getConversationID(chatingPartnerUid: message.fromId, adId: adId)}/messages/')
      .doc(message.sent.toString())
        .update({kChatRead: DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Future<void> sendMessageNotification(
      {required String fcmToken, required String chatConnId}) async {
    var data = {
      'to': fcmToken,
      'notification': {
        'title': 'message',
        'body': 'Tap to open this message',
      },
      'data': {'type': 'chat notification', 'chatConnectionId': chatConnId}
    };

    print('///////////////////////////////////////$fcmToken');
    print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/$chatConnId');
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$kPushNotificationBearerToken'
        });
  }

  static String getConversationID({required String chatingPartnerUid, required int adId}) =>
      user.uid.hashCode <= chatingPartnerUid.hashCode
          ? '${user.uid}_${adId}_$chatingPartnerUid'
          : '${chatingPartnerUid}_${adId}_${user.uid}';
}

enum ChatUserList { buying, selling }
