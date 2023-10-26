part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  final RequestOTPEntity? requestOTP;
  final Exception? exception;

  const LoginInitial({this.exception, this.requestOTP});

  @override
  List<Object> get props => [exception ?? Exception(), requestOTP ?? {}];
}

final class OTPRequestLoading extends LoginState {}

final class OTPRequestSuccess extends LoginState {
  final String otpId;
  final RequestOTPEntity requestOTP;
  final Exception? exception;

  const OTPRequestSuccess({
    this.exception,
    required this.otpId,
    required this.requestOTP,
  });

  @override
  List<Object> get props => [exception ?? Exception(), otpId, requestOTP];
}

final class SignInRequestLoading extends LoginState {}

final class SignInRequestSuccess extends LoginState {
  final NewAuthEntity newAuth;

  const SignInRequestSuccess(this.newAuth);

  @override
  List<Object> get props => [newAuth];
}
