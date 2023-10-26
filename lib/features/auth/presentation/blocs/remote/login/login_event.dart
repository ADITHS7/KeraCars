part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EditNumber extends LoginEvent {
  final String credential;
  final bool receiveInstantUpdate;

  const EditNumber(
    this.credential,
    this.receiveInstantUpdate,
  );

  @override
  List<Object> get props => [credential, receiveInstantUpdate];
}

class CheckBoxChanged extends LoginEvent {
  final bool receiveInstantUpdate;

  const CheckBoxChanged(this.receiveInstantUpdate);

  @override
  List<Object> get props => [receiveInstantUpdate];
}

class RequestOTP extends LoginEvent {
  final String credential;
  final bool receiveInstantUpdate;

  const RequestOTP(
    this.credential,
    this.receiveInstantUpdate,
  );

  @override
  List<Object> get props => [credential, receiveInstantUpdate];
}

class RequestSignIn extends LoginEvent {
  final OTPLoginEntity otpLogin;

  const RequestSignIn(this.otpLogin);

  @override
  List<Object> get props => [otpLogin];
}
