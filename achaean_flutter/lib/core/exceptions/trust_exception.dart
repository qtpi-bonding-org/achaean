class TrustException implements Exception {
  final String message;
  final Object? cause;
  const TrustException(this.message, [this.cause]);

  @override
  String toString() => 'TrustException: $message';
}
