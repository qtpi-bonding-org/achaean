class ProfileException implements Exception {
  final String message;
  final Object? cause;
  const ProfileException(this.message, [this.cause]);

  @override
  String toString() => 'ProfileException: $message';
}
