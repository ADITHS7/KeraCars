import "package:dio/dio.dart";
import "package:equatable/equatable.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:keracars_app/core/error/network_exception.dart";
import "package:keracars_app/core/security/token_service.dart";
import "package:keracars_app/features/auth/data/models/models.dart";
import "package:keracars_app/features/auth/data/repositories/repositories.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc(
    this._tokenService,
    this._authRepository,
  ) : super(AuthInitial()) {
    on<CheckAuthentication>(_checkAuthentication);
    on<AddAuthentication>(_addAuthentication);
    on<RemoveAuthentication>(_removeAuthentication);
  }

  final TokenService _tokenService;
  final AuthRepository _authRepository;

  Future<void> _checkAuthentication(
      CheckAuthentication event, Emitter<AuthState> emit) async {
    try {
      await _tokenService.getNewAccessToken();
      return emit(AuthAuthenticated());
    } on DioException catch (e) {
      switch (e.runtimeType) {
        case BadRequestException:
        case UnauthorizedException:
          return emit(AuthUnauthenticated());
        default:
          final rToken = await _tokenService.getRefreshToken();
          if (rToken != null) return emit(AuthAuthenticated());

          return emit(AuthUnauthenticated());
      }
    }
  }

  Future<void> _addAuthentication(
      AddAuthentication event, Emitter<AuthState> emit) async {
    await _tokenService.setAccessToken(event.newAuth.accessToken);
    await _tokenService.setRefreshToken(event.newAuth.refreshToken);
    return emit(AuthAuthenticated());
  }

  Future<void> _removeAuthentication(
      RemoveAuthentication event, Emitter<AuthState> emit) async {
    final refreshToken = await _tokenService.getRefreshToken();
    if (refreshToken != null) await _authRepository.logoutUser(refreshToken);

    await _tokenService.deleteAccessToken();
    await _tokenService.deleteRefreshToken();

    return emit(AuthUnauthenticated());
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json["authenticated"] == true) {
      return AuthAuthenticated();
    }
    return AuthUnauthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {"authenticated": state is AuthAuthenticated};
  }
}
