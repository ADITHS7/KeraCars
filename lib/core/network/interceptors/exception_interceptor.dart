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
        throw DeadlineExceededException(message: err.message);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(message: err.response?.data['message'] ?? err.message);
          case 401:
            throw UnauthorizedException(message: err.response?.data['message'] ?? err.message);
          case 403:
            throw ForbiddenException(message: err.response?.data['message'] ?? err.message);
          case 404:
            throw NotFoundException(message: err.response?.data['message'] ?? err.message);
          case 409:
            throw ConflictException(message: err.response?.data['message'] ?? err.message);
          case 500:
            throw InternalServerErrorException(message: err.response?.data['message'] ?? err.message);
        }
        break;
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(message: err.message);
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        throw err;
      case DioExceptionType.cancel:
        break;
    }

    return handler.next(err);
  }
}
