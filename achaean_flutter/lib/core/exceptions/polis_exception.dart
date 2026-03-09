class PolisException implements Exception {
  final String message;
  final Object? cause;
  const PolisException(this.message, [this.cause]);

  @override
  String toString() => 'PolisException: $message';
}
