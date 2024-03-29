part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AuthLoginEvent extends AuthEvent {}


//----------------------------------------------------------------------------
class SignOutEvent extends AuthEvent {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class SendOtpToPhoneEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpToPhoneEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
class UpdateAccountDataEvent extends AuthEvent {
  final AccountModels accountData;
  final XFile? profileImage;
  const UpdateAccountDataEvent({required this.accountData, this.profileImage});
}

class VerifySentOtpEvent extends AuthEvent {
  final String otpCode;
  final String verificationId;

  const VerifySentOtpEvent(
      {required this.otpCode, required this.verificationId});

  @override
  List<Object> get props => [otpCode, verificationId];
}

class OnPhoneOtpSent extends AuthEvent {
  final String verificationId;
  final int? token;
  const OnPhoneOtpSent({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

class OnPhoneAuthErrorEvent extends AuthEvent {
  final String error;
  const OnPhoneAuthErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class OnPhoneAuthVerificationCompleteEvent extends AuthEvent {
  final AuthCredential credential;
  const OnPhoneAuthVerificationCompleteEvent({
    required this.credential,
  });
}


class AuthSigninCheckEvent extends AuthEvent {
  final String uid;

  const AuthSigninCheckEvent(this.uid);
  @override
  List<Object> get props => [uid];
}

class AuthCraetionEvent extends AuthEvent {
  final AccountModels accountModels;

  const AuthCraetionEvent(this.accountModels);

  @override
  List<Object> get props => [accountModels];
}
