part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class RequestOTP extends LoginEvent {
  final String credential;

  const RequestOTP(this.credential);

  @override
  List<Object> get props => [credential];
}

class RequestSignIn extends LoginEvent {
  final OTPLoginEntity otpLogin;

  const RequestSignIn(this.otpLogin);

  @override
  List<Object> get props => [otpLogin];
}
