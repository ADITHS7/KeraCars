import "package:keracars_app/core/network/resources/data_state.dart";
import "package:keracars_app/core/network/service/services.dart";
import "package:keracars_app/core/storage/storage_service.dart";
import "package:keracars_app/features/auth/domain/repositories/repositories.dart";

class TokenService {
  final DioService _dioService;
  final AuthRepository _authRepository;
  final StorageService _storageService;

  String? _accessToken;
  String? _refreshToken;

  static const String _accessTokenKey = "keracars_accessToken";
  static const String _refreshTokenKey = "keracars_refreshToken";

  TokenService({
    required DioService dioService,
    required StorageService storageService,
    required AuthRepository authRepository,
  })  : _dioService = dioService,
        _storageService = storageService,
        _authRepository = authRepository;

  Future<void> setAccessToken(String token) async {
    _dioService.setAccessTokenHeader(accessToken: token);
    await _storageService.set(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null) return _accessToken;

    _accessToken = await _storageService.get(_accessTokenKey);
    return _accessToken;
  }

  Future<void> deleteAccessToken() async {
    _dioService.deleteAccessTokenHeader();
    _accessToken = null;
    await _storageService.delete(_accessTokenKey);
  }

  Future<void> setRefreshToken(String token) async {
    await _storageService.set(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    if (_refreshToken != null) return _refreshToken;

    _refreshToken = await _storageService.get(_refreshTokenKey);
    return _refreshToken;
  }

  Future<void> deleteRefreshToken() async {
    _refreshToken = null;
    await _storageService.delete(_refreshTokenKey);
  }

  /// refresh authentications
  Future<String?> getNewAccessToken() async {
    final dataState = await _authRepository.refreshAccessToken(_refreshToken ?? await getRefreshToken() ?? "would fail");
    if (dataState is DataFailed) throw dataState.error!;

    String token = dataState.data!;
    await setAccessToken(token);
    return token;
  }
}
