import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:keracars_app/core/network/resources/data_state.dart';
import 'package:keracars_app/features/auth/domain/entities/entities.dart';
import 'package:keracars_app/features/auth/domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc(
    this._checkAuthenticationUseCase,
    this._addAuthenticationUseCase,
    this._removeAuthenticationUseCase,
  ) : super(AuthInitial()) {
    on<CheckAuthentication>(_checkAuthentication);
    on<AddAuthentication>(_addAuthentication);
    on<RemoveAuthentication>(_removeAuthentication);
  }

  final CheckAuthenticationUseCase _checkAuthenticationUseCase;
  final AddAuthenticationUseCase _addAuthenticationUseCase;
  final RemoveAuthenticationUseCase _removeAuthenticationUseCase;

  Future<void> _checkAuthentication(CheckAuthentication event, Emitter<AuthState> emit) async {
    final dataState = await _checkAuthenticationUseCase.execute(params: null);

    if (dataState is DataSuccess) {
      return emit(AuthAuthenticated(error: dataState.error != null, exception: dataState.error));
    }
    return emit(AuthUnauthenticated());
  }

  Future<void> _addAuthentication(AddAuthentication event, Emitter<AuthState> emit) async {
    final dataState = await _addAuthenticationUseCase.execute(params: event.newAuth);

    if (dataState is DataSuccess && dataState.data!) {
      return emit(AuthAuthenticated());
    }
    return emit(AuthUnauthenticated());
  }

  Future<void> _removeAuthentication(RemoveAuthentication event, Emitter<AuthState> emit) async {
    final dataState = await _removeAuthenticationUseCase.execute(params: null);

    if (dataState is DataSuccess && dataState.data!) {
      return emit(AuthUnauthenticated());
    }
    return emit(AuthAuthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json['authenticated'] == true) {
      return AuthAuthenticated();
    }
    return AuthUnauthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {'authenticated': state is AuthAuthenticated};
  }
}
