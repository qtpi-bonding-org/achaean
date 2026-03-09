class PostException implements Exception {
  final String message;
  final Object? cause;
  const PostException(this.message, [this.cause]);

  @override
  String toString() => 'PostException: $message';
}
