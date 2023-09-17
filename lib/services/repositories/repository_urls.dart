const String getAdEndpoint = "https://nic.calletic.com/api/getads";
const String sortAdsEndpoint = "https://nic.calletic.com/api/adssorting";
const String searchAdsEndpoint = "https://nic.calletic.com/api/searchads";


const String getAccount ="https://nic.calletic.com/api/account/get?user_id=";
const String updateUserAccount ="https://nic.calletic.com/api/account/update"; 

const String convertedToPremiumAd ="http://nic.calletic.com/api/convert_to_premium";
const String markAdAsSold ="http://nic.calletic.com/api/mark_as_soldout";

const String createAdsEndpoint ="http://nic.calletic.com/api/create-ads";
const String updateAdsEndpoint ="http://nic.calletic.com/api/updateads";//

const String imageUrlEndpoint ="https://nic.calletic.com/storage/app/"; 

const noOfAdPerPage = 6;

class ApiEndpoints {
  static String getAdsUrl(int page,String pincode) => '$getAdEndpoint?pincode=$pincode&per_page=$noOfAdPerPage&page=$page';
  static String get getSelectedAd => getAdEndpoint;
  static String get getAccountUrl => getAccount;
  static String get createAdsUrl => createAdsEndpoint;
  static String updateAdUrl(int id) => '$updateAdsEndpoint/$id';
  static String convertedToPremium(int id) => '$convertedToPremiumAd/$id';
  static String markAsSold(int id) => '$markAdAsSold/$id';
  static String sortAdsUrl(String? routName, String pincode, int page) => '$sortAdsEndpoint$routName?pincode=$pincode&per_page=$noOfAdPerPage&page=$page';
  static String searchAdsUrl(String searchingWord, String pincode, int page) => '$searchAdsEndpoint?searching_word=$searchingWord&pincode=$pincode&per_page=$noOfAdPerPage&page=$page';
  static String get updateUserAccountUrl => updateUserAccount;
}