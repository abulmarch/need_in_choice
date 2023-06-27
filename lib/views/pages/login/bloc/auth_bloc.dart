import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/firebase/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authrepo authrepo;
  final auth = FirebaseAuth.instance;

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
    try {
      emit(AuthLoading());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: event.verificationId, smsCode: event.otpCode);
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      print("credentila $credential");
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  FutureOr<void> _loginWithCredential(
      OnPhoneAuthVerificationCompleteEvent event,
      Emitter<AuthState> emit) async {
    try {
      await auth.signInWithCredential(event.credential).then((user) {
        if (user.user != null) {
          emit(AuthVerified());
        
      });
    } on FirebaseAuthException catch (e) {
      emit(AuthError(error: e.code));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
