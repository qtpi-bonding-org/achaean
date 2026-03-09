import '../models/account_creation_result.dart';

/// Orchestrates the full account creation flow.
abstract class IAccountCreationService {
  Future<AccountCreationResult> createAccount({
    required String username,
    required String email,
    required String password,
  });
}
