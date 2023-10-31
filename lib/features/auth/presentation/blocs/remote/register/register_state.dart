part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final Exception exception;

  const RegisterError(this.exception);

  @override
  List<Object> get props => [exception];
}

final class RegisterSuccess extends RegisterState {
  final RegisterUserEntity registerUser;

  const RegisterSuccess(this.registerUser);

  @override
  List<Object> get props => [registerUser];
}
