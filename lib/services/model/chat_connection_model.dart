import 'package:need_in_choice/services/repositories/firestore_chat.dart';

import '../repositories/firestore_chat_constant.dart';

class ChatConnectionModel {
  final int adId;
  final String adCreatorUid;
  final String adsImage;
  final String adTitle;
  final String connectionGenUid;
  final String connectionGenTime;
  final String? connectionDocId;
  final bool isChatDeleted;

  ChatConnectionModel(
      {required this.adId,
      required this.adCreatorUid,
      required this.adsImage,
      required this.adTitle,
      required this.connectionGenUid,
      required this.connectionGenTime,
      this.connectionDocId,
      required this.isChatDeleted});
  factory ChatConnectionModel.fromJson(
      Map<String, dynamic> json, String? chatConnectionId) {
    return ChatConnectionModel(
        adId: json[kAdId],
        adCreatorUid: json[kAdCreatorUid],
        adsImage: json[kAdsImage],
        adTitle: json[kAdTitle],
        connectionGenUid: json[kConnectionGenUid],
        connectionGenTime: json[kConnectionGenTime],
        connectionDocId: chatConnectionId,
        isChatDeleted: json[kIsChatDeleted]);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      kAdCreatorUid: adCreatorUid,
      kAdId: adId,
      kAdsImage: adsImage,
      kAdTitle: adTitle,
      kConnectionGenUid: connectionGenUid,
      kConnectionGenTime: connectionGenTime,
      kIsChatDeleted: isChatDeleted
    };
  }
}

extension ConversationPartner on ChatConnectionModel {
  String chattingPartnerUid() =>
      adCreatorUid != FireStoreChat.user.uid ? adCreatorUid : connectionGenUid;
}
