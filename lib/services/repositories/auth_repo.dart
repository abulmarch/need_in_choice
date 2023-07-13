import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../model/account_model.dart';

const String endpoint = "http://nic.calletic.com/api/account";

class Authrepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future createAccount({required AccountModels postData}) async {
    const String url = "$endpoint/create";
    final finalurl = Uri.parse(url);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map requestbody = {
      'user_id': postData.userId,
      'name': postData.name,
      'phone': postData.phone,
      'address': postData.address,
    };

    final jsonBody = jsonEncode(requestbody);
    final response =
        await http.post(finalurl, headers: headers, body: jsonBody);

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    } else if (response.statusCode == 200) {
      return true;
    }
  }

  static Future<AccountModels?> fetchAccountsData(String uid) async {
    try {
      final String url = "$endpoint+get?user_id=$uid";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final accounts = responseData['results'];
        return AccountModels.fromJson(accounts);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkUserExists(String uid) async {
    final String url = "$endpoint/get?user_id=$uid";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
