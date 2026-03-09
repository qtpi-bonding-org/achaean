/// Base exception for all Git client errors.
class GitException implements Exception {
  final String message;
  final int? statusCode;
  final String? body;

  const GitException(this.message, {this.statusCode, this.body});

  @override
  String toString() => 'GitException: $message (status: $statusCode)';
}

class GitNotFoundException extends GitException {
  const GitNotFoundException(super.message, {super.statusCode, super.body});
}

class GitUnauthorizedException extends GitException {
  const GitUnauthorizedException(super.message, {super.statusCode, super.body});
}

class GitConflictException extends GitException {
  const GitConflictException(super.message, {super.statusCode, super.body});
}

class GitRateLimitException extends GitException {
  const GitRateLimitException(super.message, {super.statusCode, super.body});
}

class GitUnexpectedException extends GitException {
  const GitUnexpectedException(super.message, {super.statusCode, super.body});
}
