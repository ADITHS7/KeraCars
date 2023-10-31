part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisteringUser extends RegisterEvent {
  final RegisterUserEntity registerUser;

  const RegisteringUser(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}
