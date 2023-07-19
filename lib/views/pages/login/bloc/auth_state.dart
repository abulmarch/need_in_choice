part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthNotVerified extends AuthState {}

class AuthVerified extends AuthState {}

class AuthCodeSentSuccess extends AuthState {
  final String verificationId;
  const AuthCodeSentSuccess({
    required this.verificationId,
  });
  @override
  List<Object> get props => [verificationId];
}

class AuthLoggedIn extends AuthState {
  final AccountModels accountModels;

  const AuthLoggedIn(this.accountModels);
  @override
  List<Object> get props => [accountModels];
}

class AuthNotLoggedIn extends AuthState {}

class AuthCreatedfailed extends AuthState {
  final String error;

  const AuthCreatedfailed(this.error);

  @override
  List<Object> get props => [error];
}

class AuthAccountCreated extends AuthState {
  final AccountModels accountModels;

  const AuthAccountCreated(this.accountModels);
  @override
  List<Object> get props => [accountModels];
}
