part of "verify_otp_bloc.dart";

sealed class VerifyOtpState extends Equatable {
  final String otpId;

  const VerifyOtpState({this.otpId = ""});

  @override
  List<Object> get props => [otpId];
}

final class VerifyOtpInitial extends VerifyOtpState {
  const VerifyOtpInitial({super.otpId});
}

final class SignInRequestLoading extends VerifyOtpState {
  const SignInRequestLoading({super.otpId});
}

final class SignInRequestError extends VerifyOtpState {
  final Exception? exception;

  const SignInRequestError(this.exception, {super.otpId});

  @override
  List<Object> get props => [exception ?? Exception()];
}

final class SignInRequestSuccess extends VerifyOtpState {
  final NewAuthModel newAuth;

  const SignInRequestSuccess(this.newAuth, {super.otpId});

  @override
  List<Object> get props => [newAuth];
}
