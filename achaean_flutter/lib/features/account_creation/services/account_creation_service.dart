import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import '../../../core/exceptions/account_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/try_operation.dart';
import '../models/account_creation_result.dart';
import 'i_account_creation_service.dart';

class AccountCreationService implements IAccountCreationService {
  final IKeyService _keyService;
  final IGitRegistration _gitRegistration;
  final IGitService _gitService;

  AccountCreationService(
    this._keyService,
    this._gitRegistration,
    this._gitService,
  );

  @override
  Future<AccountCreationResult> createAccount({
    required String username,
    required String email,
    required String password,
  }) {
    return tryMethod(
      () async {
        // 1. Generate and store keypair
        final pubkeyHex = await _keyService.generateAndStoreKeypair();

        // 2. Register with git host
        final credentials = await _gitRegistration.register(
          username: username,
          email: email,
          password: password,
        );

        // 3. Configure git service with returned credentials
        await _gitService.configure(
          baseUrl: credentials.baseUrl,
          token: credentials.token,
          username: credentials.username,
          hostType: credentials.hostType,
        );

        // 4. Scaffold Koinon repo
        final client = await _gitService.getClient();
        final repoName = 'koinon';
        final repoHttps = '${credentials.baseUrl}/${credentials.username}/$repoName';

        final repo = await RepoScaffolder(client).scaffold(
          repoName: repoName,
          pubkey: pubkeyHex,
          repoHttps: repoHttps,
        );

        return AccountCreationResult(
          pubkeyHex: pubkeyHex,
          repoOwner: repo.owner,
          repoName: repo.name,
          repoUrl: repo.htmlUrl,
        );
      },
      AccountException.new,
      'createAccount',
    );
  }
}
