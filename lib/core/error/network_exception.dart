sealed class NetworkException implements Exception {
  const NetworkException({this.message}) : super();

  final String? message;
}

/// 400
class BadRequestException extends NetworkException {
  BadRequestException({super.message});
}

/// 401
class UnauthorizedException extends NetworkException {
  UnauthorizedException({super.message});
}

/// 403
class ForbiddenException extends NetworkException {
  ForbiddenException({super.message});
}

/// 404
class NotFoundException extends NetworkException {
  NotFoundException({super.message});
}

/// 409
class ConflictException extends NetworkException {
  ConflictException({super.message});
}

/// 500
class InternalServerErrorException extends NetworkException {
  InternalServerErrorException({super.message});
}

/// no internet
class NoInternetConnectionException extends NetworkException {
  NoInternetConnectionException({super.message});
}

/// slow internet / timeout
class DeadlineExceededException extends NetworkException {
  DeadlineExceededException({super.message});
}
