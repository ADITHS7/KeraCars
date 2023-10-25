part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthentication extends AuthEvent {}

class AddAuthentication extends AuthEvent {
  final NewAuthEntity newAuth;

  const AddAuthentication(this.newAuth);

  @override
  List<Object> get props => [newAuth];
}

class RemoveAuthentication extends AuthEvent {}
