import "package:dio/dio.dart";
import "package:get_it/get_it.dart";
import "package:keracars_app/core/security/token_service.dart";
import "package:keracars_app/features/auth/blocs/blocs.dart";

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
        GetIt.I<AuthBloc>().add(RemoveAuthentication());
      }
    }
    return handler.next(err);
  }
}
