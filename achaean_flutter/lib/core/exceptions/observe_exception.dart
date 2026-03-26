class ObserveException implements Exception {
  final String message;
  final Object? cause;
  const ObserveException(this.message, [this.cause]);

  @override
  String toString() => 'ObserveException: $message';
}
