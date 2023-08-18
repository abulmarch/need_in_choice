import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  final _fireBaseMessaging = FirebaseMessaging.instance;
  Future<void> handleBackgroundMessage(RemoteMessage message) async{
    log('''
    title : ${message.notification?.title}
    body : ${message.notification?.body}
    data : ${message.data}
    category : ${message.category}
    from : ${message.from}
    messageId : ${message.messageId}
    senderId : ${message.senderId}
    messageType : ${message.messageType}

    
    message.notification.toString() : ${message.notification.toString()}
    ''');
  }
  Future<void> initNotification() async{
    try {
      await _fireBaseMessaging.requestPermission();
      final fCMToken = await _fireBaseMessaging.getToken();
      log('fCMToken:----:|>$fCMToken   ');
      FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {
        log('fcmToken [onTokenRefresh] : $fcmToken');
      })
      .onError((err) {
        log('fcmToken err [onTokenRefresh] : $err');
      });
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } catch (e) {
      log('eeeeeeee:   $e');
    }
  }

}


// AAAAxFqFtxU:APA91bEnNJXU4m4nV_Rsb5pDHSmei7TLxjp5jfPdkDTCNRs2wYhk2Bg7G5-kg9dUtuPOdi4dwLh0oBza03Jca0bjcHoQhWySlqtXx7TOFfjfse2BtQgbgGoOOQgpxBuap_cB_KotUNMc


// POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send