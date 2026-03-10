class QueryException implements Exception {
  final String message;
  final Object? cause;
  const QueryException(this.message, [this.cause]);

  @override
  String toString() => 'QueryException: $message';
}
