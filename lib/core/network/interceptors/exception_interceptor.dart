import 'package:dio/dio.dart';
import 'package:keracars_app/core/error/network_exception.dart';

class ExceptionInterceptor extends Interceptor {
  ExceptionInterceptor({required Dio dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(requestOptions: err.requestOptions, response: err.response);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(requestOptions: err.requestOptions, response: err.response);
          case 401:
            throw UnauthorizedException(requestOptions: err.requestOptions, response: err.response);
          case 403:
            throw ForbiddenException(requestOptions: err.requestOptions, response: err.response);
          case 404:
            throw NotFoundException(requestOptions: err.requestOptions, response: err.response);
          case 409:
            throw ConflictException(requestOptions: err.requestOptions, response: err.response);
          case 500:
            throw InternalServerErrorException(requestOptions: err.requestOptions, response: err.response);
        }
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(requestOptions: err.requestOptions, response: err.response);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        throw err;
      case DioExceptionType.cancel:
        break;
    }

    return handler.next(err);
  }
}
