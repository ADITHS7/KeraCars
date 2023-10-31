part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final RequestOTPEntity requestOTP;

  const LoginState({
    RequestOTPEntity? requestOTPEntity,
  }) : requestOTP = requestOTPEntity ?? const RequestOTPEntity(credential: '', receiveUpdate: false);

  @override
  List<Object> get props => [requestOTP];
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.requestOTPEntity});
}

final class OTPRequestLoading extends LoginState {
  const OTPRequestLoading({super.requestOTPEntity});
}

final class OTPRequestError extends LoginState {
  final Exception? exception;

  const OTPRequestError({super.requestOTPEntity, this.exception});

  @override
  List<Object> get props => [exception ?? Exception()];
}

final class OTPRequestSuccess extends LoginState {
  final String otpId;
  final bool resending;

  const OTPRequestSuccess({
    required this.otpId,
    required super.requestOTPEntity,
    required this.resending,
  });

  @override
  List<Object> get props => [otpId, resending];
}
