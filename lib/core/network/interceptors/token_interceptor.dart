import 'package:dio/dio.dart';
import 'package:keracars_app/core/network/service/token_service.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  final TokenService _tokenService;

  TokenInterceptor({
    required Dio dio,
    required TokenService tokenService,
  })  : _dio = dio,
        _tokenService = tokenService;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // If a 401 response is received, refresh the access token
      try {
        String? newAccessToken = await _tokenService.getNewAccessToken();

        // Update the request header with the new access token
        if (newAccessToken != null) {
          _tokenService.setAccessToken(newAccessToken);

          // Repeat the request with the updated header
          return handler.resolve(await _dio.fetch(err.requestOptions));
        }
      } catch (_) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}
