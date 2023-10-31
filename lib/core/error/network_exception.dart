import 'package:dio/dio.dart';

sealed class NetworkException extends DioException implements Exception {
  NetworkException({required super.requestOptions, super.response});

  @override
  String? get message => response?.data['message'];
}

/// 400
class BadRequestException extends NetworkException {
  BadRequestException({required super.requestOptions, super.response});
}

/// 401
class UnauthorizedException extends NetworkException {
  UnauthorizedException({required super.requestOptions, super.response});
}

/// 403
class ForbiddenException extends NetworkException {
  ForbiddenException({required super.requestOptions, super.response});
}

/// 404
class NotFoundException extends NetworkException {
  NotFoundException({required super.requestOptions, super.response});
}

/// 409
class ConflictException extends NetworkException {
  ConflictException({required super.requestOptions, super.response});
}

/// 500
class InternalServerErrorException extends NetworkException {
  InternalServerErrorException({required super.requestOptions, super.response});
}

/// no internet
class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException({required super.requestOptions, super.response});
}

/// slow internet / timeout
class DeadlineExceededException extends NetworkException {
  DeadlineExceededException({required super.requestOptions, super.response});
}
