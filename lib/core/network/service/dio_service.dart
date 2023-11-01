import "package:dio/dio.dart";

class DioService {
  DioService({
    required String baseUrl,
    String? accessToken,
    List<Interceptor>? interceptors,
    String? contentType,
  }) : _dio = DioService.createDio(
          baseUrl: baseUrl,
          accessToken: accessToken,
          interceptors: interceptors,
          contentType: contentType,
        );

  final Dio _dio;

  Dio get dio => _dio;

  static Dio createDio({
    required String baseUrl,
    String? accessToken,
    List<Interceptor>? interceptors,
    String? contentType,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        headers: {"Authorization": "Bearer $accessToken"},
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        contentType: contentType,
      ),
    );

    dio.interceptors.addAll([...?interceptors]);

    return dio;
  }
}
