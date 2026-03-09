import 'package:dart_git/dart_git.dart';
import 'package:injectable/injectable.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../core/exceptions/account_exception.dart';
import '../../core/exceptions/post_exception.dart';

/// Global exception mapper for the application.
///
/// Maps all application exceptions to user-friendly message keys
/// that can be localized and displayed to users.
@LazySingleton(as: IExceptionKeyMapper)
class AppExceptionKeyMapper implements IExceptionKeyMapper {
  @override
  MessageKey? map(Object exception) {
    return switch (exception) {
      AccountException() => const MessageKey.error('account.creation.error'),
      PostException() => const MessageKey.error('post.creation.error'),
      GitUnauthorizedException() =>
        const MessageKey.error('error.auth.unauthorized'),
      GitNotFoundException() => const MessageKey.error('error.generic'),
      GitRateLimitException() => const MessageKey.error('error.generic'),
      GitException() => const MessageKey.error('error.generic'),
      _ => null,
    };
  }
}
