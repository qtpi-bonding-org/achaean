class GitServiceException implements Exception {
  final String message;
  final Object? cause;
  const GitServiceException(this.message, [this.cause]);

  @override
  String toString() => 'GitServiceException: $message';
}
