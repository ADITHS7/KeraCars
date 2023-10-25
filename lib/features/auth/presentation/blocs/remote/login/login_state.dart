part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class OTPRequestError extends LoginState {
  final Exception exception;

  const OTPRequestError(this.exception);

  @override
  List<Object> get props => [exception];
}

final class OTPRequestSuccess extends LoginState {
  final String otpId;

  const OTPRequestSuccess({required this.otpId});

  @override
  List<Object> get props => [otpId];
}

final class SignInRequestError extends LoginState {
  final String otpId;
  final Exception exception;

  const SignInRequestError(this.exception, {required this.otpId});

  @override
  List<Object> get props => [exception, otpId];
}

final class SignInRequestSuccess extends LoginState {
  final NewAuthEntity newAuth;

  const SignInRequestSuccess(this.newAuth);

  @override
  List<Object> get props => [newAuth];
}
