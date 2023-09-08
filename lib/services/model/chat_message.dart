

import 'package:intl/intl.dart' show DateFormat;

import '../repositories/firestore_chat_constant.dart';

class ChatMessage{
  ChatMessage({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  final String toId;
  final String msg;
  final String read;
  final String fromId;
  final ChatTime sent;
  final Type type;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      toId: json[kChatToId], 
      msg: json[kChatMsg], 
      read: json[kChatRead], 
      type: json[kChatType] == Type.image.name ? Type.image : Type.text, 
      fromId: json[kChatFromId], 
      sent: ChatTime(json[kChatSent]),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      kChatToId: toId,
      kChatMsg: msg,
      kChatRead: read,
      kChatType: type.name,
      kChatFromId: fromId,
      kChatSent: sent.toString(),
    };
    return data;
  }
}

class ChatTime{
  final String time;
  ChatTime(this.time);

  @override
  String toString() {
    return time;
  }
}

extension ConvertToTimeFormat on ChatTime {
    /// it convert from '1692082334621' to '12:07 PM'
  String convertToTime(){
    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return DateFormat('h:mm a').format(dateTime);
  }
  String extractDate(){
    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final date = DateFormat('yMd').format(dateTime);
    return date == DateFormat('yMd').format(DateTime.now()) ? 'Today' : date;
  }
}