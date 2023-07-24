import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/account_model.dart';

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
      final accountData = await authrepo.fetchAccountsData(uid);
      if (accountData != null) {
        AccountSingleton.instance.setAccountModels = accountData;
        emit(AuthLoggedIn(accountData));
      } else {
        emit(AuthNotLoggedIn());
      }
    } catch (e) {
      emit(AuthNotLoggedIn());
    }
  }

  FutureOr<void> _onCreate(
      AuthCraetionEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool accountCreated =
          await authrepo.createAccount(postData: event.accountModels);
      if (accountCreated) {
        AccountSingleton.instance.setAccountModels = event.accountModels;

        await Future.delayed(const Duration(seconds: 2));
        emit(AuthAccountCreated(event.accountModels));
      } else {
        emit(AuthCreatedfailed(e.toString()));
      }
    } catch (e) {
      emit(AuthCreatedfailed(e.toString()));
    }
  }
}
