class KeyException implements Exception {
  final String message;
  final Object? cause;
  const KeyException(this.message, [this.cause]);

  @override
  String toString() => 'KeyException: $message';
}
