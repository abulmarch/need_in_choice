import 'dart:developer';

import 'package:need_in_choice/utils/extension_data.dart';

class AdsModel {
  final int id;
  final String userId;
  final String adsTitle;
  final String description;
  final bool isPremium;
  final String mainCategory;
  final String createdDate;
  final String? profileImage;

  final List<String> images;
  final List otherimages;
  final Map<String, dynamic> categoryInfo;
  final String timeAgo;

  final String? whatsappNo;
  final String userName;
  final String phoneNo;

  final Map<String, dynamic> primaryData;
  final Map<String, dynamic> moreInfoData;
  final dynamic adPrice;

  final String routeName;

  AdsModel({
    required this.id,
    required this.userId,
    required this.adsTitle,
    required this.description,
    required this.isPremium,
    required this.mainCategory,
    required this.createdDate,
    this.profileImage,
    required this.images,
    required this.categoryInfo,
    required this.timeAgo,
    required this.phoneNo,
    required this.userName,
    this.whatsappNo,
    required this.primaryData,
    required this.moreInfoData,
    required this.otherimages,
    this.adPrice,
    required this.routeName,
  });
  factory AdsModel.fromJson(Map map) {
    log(map.toString());
    try {
      final mainCategory = map['main_category'];
      return AdsModel(
        id: map['id'],
        userId: map['user_id'],
        adsTitle: map['ads_title'],
        description: map['description'],

        isPremium: map['is_premium'] == 1 ? true : false, // is_premium : 1, 0
        mainCategory: map['main_category'],
        createdDate: map['created_at'],
        profileImage: map['profile_image'],
        images: (map['images'] as List)
            .map((img) => img['url'] as String)
            .toList(), // images : [{'url':'imagepath1.png'},{'url':'imagepath2.png'}]
        otherimages: map['otherimage'],
        categoryInfo: map[mainCategory],
        timeAgo: ConvertToTimeAgo.calculateTimeAgo(map['created_at']),
        phoneNo: map['phone'] ?? '',
        userName: map['name'] ?? '',
        whatsappNo: map['whatsapp'],
        primaryData: map[mainCategory]['primary_details'],
        moreInfoData: (map[mainCategory]['more_info'] as Map<String, dynamic>)
            .removeEmptyValue(), //map[mainCategory]['more_info'],//
        adPrice: map['ad_price'],
        routeName: map['route_name'],
      );
    } catch (e) {
      log(e.toString());
      throw '$e --->>';
    }
  }

  Map toJason(AdsModel adsModel) {
    return {
      'id': adsModel.id,
      'user_id': adsModel.userId,
      'ads_title': adsModel.adsTitle,
      'description': adsModel.description,
      'is_premium': adsModel.isPremium,
      'main_category': adsModel.mainCategory,
      'images': adsModel.images,
      'realestate': adsModel.categoryInfo,
    };
  }

  @override
  String toString() {
    return '''
    ----------------------------------->
    id : $id, userId : $userId, 
    adsTitle : $adsTitle, 
    images : $images,
    description : $description, 
    isPremium : $isPremium, 
    timeAgo : $timeAgo, 
    mainCategory : $mainCategory,
    primaryData : $primaryData
    moreInfoData : $moreInfoData
    adPrice : $adPrice
    routeName : $routeName
    
    categoryInfo : $categoryInfo

    userName : $userName
    

    ''';
  }
}

class ConvertToTimeAgo {
  static String calculateTimeAgo(String date) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(date));
    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ';
    } else {
      return 'Just now';
    }
  }
}
