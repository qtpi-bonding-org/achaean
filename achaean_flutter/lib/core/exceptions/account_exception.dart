class AccountException implements Exception {
  final String message;
  final Object? cause;
  const AccountException(this.message, [this.cause]);

  @override
  String toString() => 'AccountException: $message';
}
