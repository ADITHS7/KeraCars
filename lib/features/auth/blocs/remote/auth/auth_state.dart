part of "auth_bloc.dart";

sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final bool? error;
  final DioException? exception;

  AuthAuthenticated({this.error = false, this.exception});
}

final class AuthUnauthenticated extends AuthState {}
