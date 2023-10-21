import 'package:dio/dio.dart';
import 'package:keracars_app/core/storage/storage_service.dart';

class TokenService {
  final Dio _dio;
  final StorageService _storageService;

  String? _accessToken;
  String? _refreshToken;

  final String _accessTokenKey = 'keracars_accessToken';
  final String _refreshTokenKey = 'keracars_refreshToken';

  TokenService({
    required Dio dio,
    required StorageService storageService,
  })  : _dio = dio,
        _storageService = storageService;

  Future<void> setAccessToken(String token) async {
    _setAccessTokenHeader(accessToken: token);
    await _storageService.set(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null) return _accessToken;

    _accessToken = await _storageService.get(_accessTokenKey);
    return _accessToken;
  }

  Future<void> deleteAccessToken() async {
    _deleteAccessTokenHeader();
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

  Future<String?> getNewAccessToken() async {
    final Response response = await _dio.put(
      '/authentications',
      data: {'refreshToken': _refreshToken ?? await getRefreshToken()},
    );

    String token = response.data['accessToken'];
    await setAccessToken(token);
    return token;
  }

  void _setAccessTokenHeader({required String accessToken}) {
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  void _deleteAccessTokenHeader() => _dio.options.headers['Authorization'] = null;
}
