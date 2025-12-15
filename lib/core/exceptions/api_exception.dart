abstract class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});
}

class NetworkException extends ApiException {
  const NetworkException(super.message);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message)
      : super(statusCode: 401);
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message)
      : super(statusCode: 404);
}

class UnknownException extends ApiException {
  const UnknownException(super.message, {super.statusCode});
}
