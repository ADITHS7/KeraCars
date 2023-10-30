part of 'verify_otp_bloc.dart';

sealed class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpInit extends VerifyOtpEvent {
  final String otpId;

  const VerifyOtpInit({required this.otpId});

  @override
  List<Object> get props => [otpId];
}

class RequestSignIn extends VerifyOtpEvent {
  final OTPLoginEntity otpLogin;

  const RequestSignIn(this.otpLogin);

  @override
  List<Object> get props => [otpLogin];
}
