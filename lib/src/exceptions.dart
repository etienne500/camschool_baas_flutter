/// Custom BaaS Exceptions
class BaasException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  BaasException(this.message, {this.statusCode, this.details});

  @override
  String toString() => 'BaasException: $message (status: $statusCode)';
}

class BaasAuthException extends BaasException {
  BaasAuthException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode, details: details);
}

class BaasPermissionDeniedException extends BaasException {
  BaasPermissionDeniedException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 403, details: details);
}

class BaasNotFoundException extends BaasException {
  BaasNotFoundException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 404, details: details);
}

class BaasQuotaExceededException extends BaasException {
  BaasQuotaExceededException(String message, {int? statusCode, dynamic details})
      : super(message, statusCode: statusCode ?? 429, details: details);
}
