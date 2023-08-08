const String getAdEndpoint = "https://nic.calletic.com/api/getads";
const String sortAdsEndpoint = "https://nic.calletic.com/api/adssorting";


const String getAccount ="https://nic.calletic.com/api/account/get?user_id=";


const String createAdsEndpoint ="http://nic.calletic.com/api/create-ads";
const String updateAdsEndpoint ="http://nic.calletic.com/api/updateads";//

const String imageUrlEndpoint ="https://nic.calletic.com/storage/app/"; 



class ApiEndpoints {
  static String getAdsUrl(int page) => '$getAdEndpoint?page=$page';
  static String get getSelectedAd => getAdEndpoint;
  static String get getAccountUrl => getAccount;
  static String get createAdsUrl => createAdsEndpoint;
  static String updateAdUrl(int id) => '$updateAdsEndpoint/$id';
  static String sortAdsUrl(String? routName, int page) => '$sortAdsEndpoint$routName?page=$page';
}