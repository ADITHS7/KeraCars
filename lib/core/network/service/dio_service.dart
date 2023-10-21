import 'package:dio/dio.dart';

class DioService {
  DioService({
    required String baseUrl,
    String? accessToken,
  }) : _dio = DioService.createDio(
          baseUrl: baseUrl,
          accessToken: accessToken,
        );

  final Dio _dio;

  Dio getDio() => _dio;

  static Dio createDio({
    required String baseUrl,
    String? accessToken,
    List<Interceptor>? interceptors,
  }) {
    final Dio dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer $accessToken'},
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));

    dio.interceptors.addAll([...?interceptors]);

    return dio;
  }
}
