import '../models/account_creation_result.dart';

/// Orchestrates account connection flows.
abstract class IAccountCreationService {
  /// Run the full OAuth flow: open browser, exchange code, configure git, scaffold repo.
  /// Also stores the [indexServerUrl] for Serverpod queries.
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    required String indexServerUrl,
    String callbackUrlScheme = 'achaean',
  });
}
