class FlagException implements Exception {
  final String message;
  final Object? cause;
  const FlagException(this.message, [this.cause]);

  @override
  String toString() => 'FlagException: $message';
}
