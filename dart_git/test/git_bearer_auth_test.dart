import 'package:dart_git/dart_git.dart';
import 'package:test/test.dart';

void main() {
  group('GitBearerAuth', () {
    test('produces Bearer authorization header', () {
      final auth = GitBearerAuth('my-oauth-token');
      expect(
        auth.headers,
        equals({'Authorization': 'Bearer my-oauth-token'}),
      );
    });

    test('implements IGitAuth', () {
      final auth = GitBearerAuth('t');
      expect(auth, isA<IGitAuth>());
    });
  });
}
