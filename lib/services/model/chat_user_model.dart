
import '../repositories/firestore_chat_constant.dart';

class ChatUser{
ChatUser({
    required this.uid,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
  });
  final String uid;
  final String name;
  final String image;
  final String createdAt;
  final bool isOnline;
  final String lastActive;
  final String pushToken;

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      uid: json[kUserUid] ?? '',
      name: json[kUserName] ?? '',
      image: json[kUserImage] ?? '',
      createdAt: json[kUserCreatedAt] ?? '', 
      isOnline: json[kUserIsOnline] ?? '', 
      lastActive: json[kUserLastActive] ?? '', 
      pushToken: json[kUserPushToken] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      kUserUid : uid,
      kUserName : name,
      kUserImage : image,
      kUserCreatedAt : createdAt,
      kUserIsOnline : isOnline,
      kUserLastActive : lastActive,
      kUserPushToken : pushToken,
    };
    return data;
  }
}
