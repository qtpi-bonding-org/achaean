import '../models/account_creation_result.dart';

/// Orchestrates account connection flows.
abstract class IAccountCreationService {
  /// Run the full OAuth flow: open browser, exchange code, configure git, scaffold repo.
  /// [serverUrl] is the git server base URL (e.g. https://git.beehaw.org).
  /// [callbackUrlScheme] is the URL scheme registered for the OAuth callback (default: achaean).
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    String callbackUrlScheme = 'achaean',
  });
}
