import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../model/account_model.dart';
import 'repository_urls.dart';

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
    final url = Uri.parse(endpoint);
    final jsonBody = jsonEncode(postData);
    final response = await http.post(url, body: jsonBody);
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<AccountModels?> fetchAccountsData() async {
    try {
      final response = await http.get(Uri.parse(getAccount));
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
}
