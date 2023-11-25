part of "login_bloc.dart";

sealed class LoginState extends Equatable {
  final RequestOTPModel requestOTPModel;

  const LoginState({
    RequestOTPModel? requestOTPModel,
  }) : requestOTPModel = requestOTPModel ?? const RequestOTPModel(credential: "", receiveUpdate: false);

  @override
  List<Object> get props => [requestOTPModel];
}

final class LoginInitial extends LoginState {
  const LoginInitial({super.requestOTPModel});
}

final class OTPRequestLoading extends LoginState {
  const OTPRequestLoading({super.requestOTPModel});
}

final class OTPRequestError extends LoginState {
  final Exception? exception;

  const OTPRequestError({super.requestOTPModel, this.exception});

  @override
  List<Object> get props => [exception ?? Exception()];
}

final class OTPRequestSuccess extends LoginState {
  final String otpId;
  final bool resending;

  const OTPRequestSuccess({
    required this.otpId,
    required super.requestOTPModel,
    required this.resending,
  });

  @override
  List<Object> get props => [otpId, resending];
}
