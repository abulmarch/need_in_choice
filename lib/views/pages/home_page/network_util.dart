
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async{
    log(uri.toString());
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
        log(e.toString());
    }
    return null;
  }
}