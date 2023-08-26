import 'dart:developer';
import 'dart:convert' show jsonEncode;
import 'dart:io' show HttpHeaders;
import 'package:http/http.dart' as http show post;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/account_model.dart';
import '../model/chat_connection_model.dart';
import '../model/chat_message.dart';
import '../model/chat_user_model.dart';
import 'firestore_chat_constant.dart';
import 'key_information.dart';


class FireStoreChat{
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User user = FirebaseAuth.instance.currentUser!;

  Future<void> createChatUser({
    required String uid,
  }) async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Map<String, dynamic> chatUser = {
      'id': 'id',
      'name':'my_name',
      'is_online':false,
      'last_active': time,
      'created_at': time,
    };
    await firestore
        .collection('users')
        .doc(uid)
        .set(chatUser);
  }

  
  static Future<ChatConnectionModel?> checkChatAllreadyGenerated({
    required String creatorId,
    required int selectedAdId,
  }) async{
    try{
      final value = await firestore.collection(kTableChatConnection)
      .where(kAdId, isEqualTo: selectedAdId)
      .where(kConnectionGenUid, isEqualTo: user.uid)
      .where(kAdCreatorUid, isEqualTo: creatorId)
      .get();
      if (value.docs.isNotEmpty) {
        return ChatConnectionModel.fromJson(value.docs.first.data(),value.docs.first.id);
      }else{
        return null;
      }
    }catch(error){
      log('ERROR: checkChatAllreadyGenerated()  $error');
      return null;
    }
  }

  static Future<ChatConnectionModel?> generateNewChat({
    required String adCreatorUid,
    required int selectedAdId,
    required String adImgUrl,
    required String adTitle
  }) async{
    try {
      final docPathTime = DateTime.now().microsecondsSinceEpoch.toString();
      final generatedTime = DateTime.now().millisecondsSinceEpoch.toString();
      final conn = ChatConnectionModel(
        adId: selectedAdId, 
        adCreatorUid: adCreatorUid, 
        adsImage: adImgUrl, 
        adTitle: adTitle, 
        connectionGenUid: user.uid, 
        connectionGenTime: generatedTime,
      );
      await firestore.collection(kTableChatConnection).doc(docPathTime).set(conn.toJson());
      return conn;
    } catch (e) {
      log('-----generateNewChat(): $e --------------');
      return null;
    }
  }
  static Future<void> deleteChatConnection({
    required ChatConnectionModel chatConn,
  }) async{
    final conversationId = getConversationID(chatConn.chattingPartnerUid(), chatConn.adId);
    log('conversationId :   $conversationId');
    try {
      // await firestore.collection(kTableChatConnection)
      // .where(field)
      // .delete();
    } catch (e) {
      log('========  e deleteChatConnection() : $e  ');
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatConnectionsOfCurrentUser(ChatUserList userListType) {
    final idType = userListType == ChatUserList.buying ? kConnectionGenUid : kAdCreatorUid;
    return firestore.collection(kTableChatConnection)
    .where(idType, isEqualTo: user.uid)
    .snapshots();
  }

  static Future<void> sendMessage({
    required String msg, 
    Type type = Type.text, 
    required String toId,
    required int adId,
    required String fCMToken
  }) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final ChatMessage message = ChatMessage(
      toId: toId, 
      msg: msg, 
      read: '', 
      type: type, 
      fromId: user.uid, 
      sent: ChatTime(time)
    );

    final ref = firestore.collection('$kTableChats/${getConversationID(toId, adId)}/messages/');
    await ref.doc(time).set(message.toJson());
    // .then((value) => FireStoreChat.sendPushNotification(fCMToken: fCMToken, msg: msg));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getSelectedUserChats({
    required String receiverUid,
    required int adId,
  }) {
    return firestore.collection('$kTableChats/${getConversationID(receiverUid, adId)}/messages/')
    .orderBy('sent', descending: true)
    .snapshots();
  }
  


   // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
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
      pushToken: ''
    );
    log('-------------------------------->>>>');
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> filterUsersFromChar(List<ChatConnectionModel> chatConnList) {
    List<String> uidList = chatConnList.map((chatuser) => chatuser.chattingPartnerUid()).toList();
      return firestore
        .collection(kTableUsers)
        .where(kUserUid, whereIn: uidList.isEmpty ? [''] : uidList) //because empty list throws an error
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentChatUserInfo(String uid) {
    return firestore.collection(kTableUsers)
    .where(kUserUid, isEqualTo: uid)
    .snapshots();
  }


  static Future<void> updateUserActiveStatus(bool isOnline) async {
    firestore.collection(kTableUsers).doc(user.uid).update({
      kUserIsOnline: isOnline,
      kUserLastActive: DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  static Future<void> updateMessageReadStatus({required ChatMessage message, required int adId}) async {
    firestore
        .collection('$kTableChats/${getConversationID(message.fromId,adId)}/messages/')
        .doc(message.sent.toString())
        .update({kChatRead: DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Future<void> sendPushNotification({
    required String fCMToken,
    required String msg
   }) async {
    try {
      final body = {
        "to": 'fr2_QI87RsmzCu8LJlHE20:APA91bFOjZ-WGd2AMa8sDp8ZAb5cplkgGX_suJQC922woh-hHHNIQBYy3dkZzV8VN9BeTNsJBvy5JMJPu-Y2_GOz0wA4VSIBqIha1BC1w5_m0kTe78XkEX5RecWnnVGWm0HPvyORSL-H',
        "notification": {
          "title": 'John snow',
          "body": msg,
          "android_channel_id": "chats"
        },
      };
      var res = await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $kPushNotificationBearerToken',
            },
            body: jsonEncode(body)
          );
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static String getConversationID(String id, int adId) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_${adId}_$id'
      : '${id}_${adId}_${user.uid}';
}



enum ChatUserList{
  buying, selling
}
