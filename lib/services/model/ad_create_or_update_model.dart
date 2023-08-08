import 'dart:developer';

import 'package:image_picker/image_picker.dart' show XFile;

class AdCreateOrUpdateModel {
  final int? id;
  final String userId;
  final bool isNewAd;

  final String adsTitle;
  final String description;
  final bool isPremium;
  final List<String> imageUrls;
  final List<XFile> imageFiles;
  final List<String> urlsToDelete;
  final List<String> otherImgUrlsToDelete;
  final String mainCategory;
  final Map<String, dynamic> primaryData;
  final Map<String, dynamic> moreInfoData;
  final String adsAddress;
  final List otherImageUrls;
  final List<Map> otherImageFiles;
  final String pinCode;
  final Map adsLevels;
  final dynamic adPrice;

  final String? level4Sub;

  const AdCreateOrUpdateModel({
    this.id,
    required this.userId,
    this.isNewAd = true,
    this.description = "",
    this.adsTitle = "",
    this.isPremium = false,
    required this.mainCategory,
    this.primaryData = const {},
    this.moreInfoData = const {},
    this.adsAddress = "",
    this.imageUrls = const [],
    this.otherImageUrls = const [],
    this.imageFiles = const [],
    this.otherImageFiles = const [],
    this.urlsToDelete = const [],
    this.pinCode = "",
    this.otherImgUrlsToDelete = const [],
    this.level4Sub,
    this.adsLevels = const {},
    required this.adPrice,
  });

  factory AdCreateOrUpdateModel.fromJson(Map json) {
    final String mainCategoryName = json['main_category'];
    return AdCreateOrUpdateModel(
      id: json['id'],
      userId: json['user_id'],
      isNewAd: false,
      mainCategory: mainCategoryName,
      isPremium: json['is_premium'] == 1 ? true : false,
      adsTitle: json['ads_title'],
      description: json['description'],
      imageUrls: (json['images'] as List).map((img) => img['url'] as String).toList(),
      otherImageUrls: json['otherimage'],
      adsAddress: json[mainCategoryName]['ads_address'],
      primaryData: json[mainCategoryName]['primary_details'],
      moreInfoData: json[mainCategoryName]['more_info'],
      adsLevels: json[mainCategoryName]['ads_levels'],
      level4Sub: json[mainCategoryName]['ads_levels']['sub category'],
      adPrice: json['ad_price'],
      pinCode: json['pincode'],
    );
  }

  @override
  String toString() {
    return '''
    ----------------------------------->
    id : $id, 'userId : $userId, 'adsTitle' : $adsTitle,
    description : $description, isPremium : $isPremium, isNewAd : $isNewAd, 
    adPrice : $adPrice,
    mainCategory : $mainCategory,
    level4Sub : $level4Sub
    imageUrls : $imageUrls,
    imageFiles : $imageFiles
    urlsToDelete : $urlsToDelete
    otherImageUrls : $otherImageUrls,
    otherImageFiles : $otherImageFiles
    otherImgUrlsToDelete : $otherImgUrlsToDelete
    adsAddress : $adsAddress
    primaryData : $primaryData
    moreInfoData : $moreInfoData
    adsLevels : $adsLevels
    ''';
  }

  AdCreateOrUpdateModel copyWith({
    String? adsTitle,
    String? description,
    Map<String, dynamic>? primaryData,
    Map<String, dynamic>? moreInfoData,
    String? adsAddress,
    List<String>? imageUrls,
    List<XFile>? imageFiles,
    List<String>? urlsToDelete,
    String? pinCode,
    String? level4Sub,
    List? otherImageUrls,
    List<Map>? otherImageFiles,
    List<String>? otherImgUrlsToDelete,
    Map<String, dynamic>? adsLevels,
    dynamic adPrice,
  }) {
    return AdCreateOrUpdateModel(
        id: id,
        userId: userId,
        isNewAd: isNewAd,
        mainCategory: mainCategory,
        isPremium: isPremium,
        imageUrls: imageUrls ?? this.imageUrls,
        adsTitle: adsTitle ?? this.adsTitle,
        description: description ?? this.description,
        adsAddress: adsAddress ?? this.adsAddress,
        primaryData: primaryData ?? this.primaryData,
        moreInfoData: moreInfoData ?? this.moreInfoData,
        urlsToDelete: urlsToDelete ?? this.urlsToDelete,
        imageFiles: imageFiles ?? this.imageFiles,
        level4Sub: level4Sub ?? this.level4Sub,
        adsLevels: adsLevels ?? this.adsLevels,
        pinCode: pinCode ?? this.pinCode,
        otherImageUrls: otherImageUrls ?? this.otherImageUrls,
        otherImgUrlsToDelete: otherImgUrlsToDelete ?? this.otherImgUrlsToDelete,
        otherImageFiles: otherImageFiles ?? this.otherImageFiles,
        adPrice: adPrice ?? this.adPrice,
      );
        
  }
}
