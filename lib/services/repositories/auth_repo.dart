import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:need_in_choice/services/repositories/repository_urls.dart';

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
      log(response.body.toString());
      throw Exception(response.reasonPhrase);
    } else if (response.statusCode == 200) {
      return true;
    }
  }

  Future updateAccount({required AccountModels postData}) async {
    const String url = "$endpoint/update";
    final finalurl = Uri.parse(url);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final Map requestbody = {
      'user_id': postData.userId,
      'name': postData.name,
      'phone': postData.phone,
      'address': postData.address,
      'whatsapp': postData.whatsapp,
    };
    final jsonBody = jsonEncode(requestbody);
    try {
      final response =
          await http.post(finalurl, headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<AccountModels?> fetchAccountsData(String uid) async {
    try {
      
      final String url = "$endpoint/get?user_id=$uid";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final accounts = responseData['results'];
        final accountModel = AccountModels.fromJson(accounts);
        AccountSingleton().setAccountModels = accountModel;
        return accountModel;
      } else if(response.statusCode == 404){
        throw 'user-not-found';
      } else {
        return null;
      }
    } catch (e) {
      if (e == 'user-not-found') {
        throw UserDataNotFoundException();
      } else {
        throw Exception(e);
      }
    }
  }

  Future<bool> checkUserExists() async {
    final uid = firebaseAuth.currentUser!.uid;
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


  Future<AccountModels?> updateAccountDetails(AccountModels account) async {
    final apiUrl = Uri.parse(ApiEndpoints.updateUserAccountUrl);
    try {
      final response = await http.post(
      apiUrl,
        body: {
          'user_id': account.userId??'',
          "name": account.name??'',
          "address": account.address??'',
          "whatsapp": account.whatsapp??'',
          "selected_place": account.selectedPlace??'',
          "place_pincode": account.placePincode??'',
        }
      );
      if (response.statusCode == 200) {
        final accountmodel = await fetchAccountsData(account.userId??'');
        if (accountmodel != null) {
          return accountmodel;
        }
        log('updateAccountDetails:  ------- --Account details updated successfully');
        return null;
      } else {
        log('updateAccountDetails:  Failed to update details. Status code: ${response.request}');
        return null;
      }
    } catch (e) {
      log("-----$e-----------");
      return null;
    }
  }

  Future<AccountModels?> updateUserProfileImage(XFile xFile) async {
    final apiUrl = Uri.parse(ApiEndpoints.updateUserAccountUrl);
    try {
      var request = http.MultipartRequest('POST', apiUrl);
      String userId = AccountSingleton().getAccountModels.userId?? '';
      request.fields["user_id"] = userId;
      request.files.add(await http.MultipartFile.fromPath('profile_image', xFile.path));
      var response = await request.send();      
      if (response.statusCode == 200) {
        final accountmodel = await fetchAccountsData(userId);
        if (accountmodel != null) {
          return accountmodel;
        }
          return null;
      } else {
        log('updateUserProfileImage:  Failed to upload image. Status code: ${response.request}');
        return null;
      }
    } catch (e) {
      log('updateUserProfileImage:  Error uploading image: $e');
      return null;
    }
    
  }
}

class UserDataNotFoundException implements Exception{}