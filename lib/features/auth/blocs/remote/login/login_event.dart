part of "login_bloc.dart";

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
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
  final bool? resending;

  const RequestOTP(
    this.credential,
    this.receiveInstantUpdate, {
    this.resending,
  });

  @override
  List<Object> get props => [credential, receiveInstantUpdate];
}
