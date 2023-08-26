import 'dart:async';
import 'dart:io' show InternetAddress;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;
import 'dart:math';
import 'dart:developer' as log show log;

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/services/repositories/firestore_chat.dart';

import '../../../../services/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authrepo authrepo;

  AuthBloc({required this.authrepo}) : super(AuthInitial()) {
    on<SendOtpToPhoneEvent>(_onSendOtp);

    on<VerifySentOtpEvent>(_onVerifyOtp);

    on<OnPhoneOtpSent>(
      (event, emit) => emit(
        AuthCodeSentSuccess(verificationId: event.verificationId),
      ),
    );

    on<OnPhoneAuthErrorEvent>(
      (event, emit) => emit(
        AuthError(error: event.error),
      ),
    );

    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);

    on<SignOutEvent>(_signout);

    on<AuthLoginEvent>(_login);

    on<AuthCraetionEvent>(_onCreate);
    on<AuthSigninCheckEvent>(_checksignedIn);
    on<UpdateAccountDataEvent>(_updateAccountData);
  }

  FutureOr<void> _onSendOtp(
      SendOtpToPhoneEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await authrepo.verifyPhone(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          add(OnPhoneOtpSent(
              verificationId: verificationId, token: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          add(OnPhoneAuthErrorEvent(error: e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _onVerifyOtp(
      VerifySentOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.otpCode);
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
      OnPhoneAuthVerificationCompleteEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authrepo.firebaseAuth
          .signInWithCredential(event.credential)
          .then((user) {
        if (user.user != null) {
          emit(AuthVerified(user.user));
        } else {
          emit(AuthNotVerified());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _signout(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authrepo.signOut();
      emit(AuthSignoutState());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _checksignedIn(
      AuthSigninCheckEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final accountData = await authrepo.fetchAccountsData(event.uid);
      if (accountData != null) {
        emit(AuthLoggedIn(accountData));
      } else {
        emit(AuthNotLoggedIn());
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final uid = authrepo.firebaseAuth.currentUser!.uid;
      await _checkInternetAvailable().then((isInternetAvailable) async{
        if (isInternetAvailable) {
          final accountData = await authrepo.fetchAccountsData(uid);
          if (accountData != null) {
            log.log(accountData.toString());
            emit(AuthLoggedIn(accountData));
          } else {
            emit(AuthNotLoggedIn());
          }  
        } else {
          emit(NoInternet());
        }      
      });
    } on UserDataNotFoundException{
      String ph = authrepo.firebaseAuth.currentUser!.phoneNumber!;
      emit(UserDataNotFound(ph.replaceFirst('+91', '')));
    } catch (e) {
      log.log('AuthLoginEvent $e');
      emit(AuthNotLoggedIn());
    }
  }
  FutureOr<void> _onCreate(AuthCraetionEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool accountCreated =
          await authrepo.createAccount(postData: event.accountModels);
      if (accountCreated) {
        AccountSingleton().setAccountModels = event.accountModels;
        //create user data in firebase for chating feature
        await Future.delayed(const Duration(seconds: 1));
        emit(AuthAccountCreated(event.accountModels));
        FireStoreChat.createUser();
      } else {
        emit(AuthCreatedfailed(e.toString()));
      }
    } catch (e) {
      emit(AuthCreatedfailed(e.toString()));
    }
  }
  Future<bool> _checkInternetAvailable() async{
    try {
      await InternetAddress.lookup('google.com');
      return true;
    }catch (e){
      log.log('checkInternetAvailable  error: $e');
      return false;
    }
  }

  Future<void> _updateAccountData(UpdateAccountDataEvent event, Emitter<AuthState> emit) async{
    emit(AccountDataUpdating());
    if (event.profileImage != null) {
      final updatedData = await authrepo.updateUserProfileImage(event.profileImage!);
      if (updatedData != null) {
        emit(AuthLoggedIn(updatedData));
      }
    }else{
      final updatedData = await authrepo.updateAccountDetails(event.accountData);
      if(updatedData != null){
        emit(AuthLoggedIn(updatedData));
      }
    }
  }

  
  
}

