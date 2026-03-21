import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../../../core/exceptions/account_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/try_operation.dart';
import '../models/account_creation_result.dart';
import 'i_account_creation_service.dart';

class AccountCreationService implements IAccountCreationService {
  final IKeyService _keyService;
  final IGitOAuth _oauth;
  final IGitService _gitService;

  AccountCreationService(this._keyService, this._oauth, this._gitService);

  @override
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    String callbackUrlScheme = 'achaean',
  }) {
    return tryMethod(
      () async {
        // 1. Build OAuth URL with PKCE
        final authResult = _oauth.buildAuthorizationUrl(
          serverUrl: serverUrl,
          redirectUri: '$callbackUrlScheme://oauth-callback',
        );

        // 2. Open browser and wait for redirect
        final resultUrl = await FlutterWebAuth2.authenticate(
          url: authResult.url,
          callbackUrlScheme: callbackUrlScheme,
        );

        // 3. Parse code and state from redirect URL
        final uri = Uri.parse(resultUrl);
        final code = uri.queryParameters['code'];
        final returnedState = uri.queryParameters['state'];

        if (code == null) {
          throw AccountException('OAuth callback missing authorization code', 'connectViaOAuth');
        }
        if (returnedState != authResult.state) {
          throw AccountException('OAuth state mismatch — possible CSRF attack', 'connectViaOAuth');
        }

        // 4. Exchange code for credentials
        final credentials = await _oauth.exchangeCode(
          serverUrl: serverUrl,
          code: code,
          codeVerifier: authResult.codeVerifier,
          redirectUri: '$callbackUrlScheme://oauth-callback',
        );

        // 5. Configure git service with OAuth credentials (bearer auth)
        await _gitService.configure(
          baseUrl: credentials.baseUrl,
          token: credentials.token,
          username: credentials.username,
          hostType: credentials.hostType,
          authType: 'bearer',
        );

        // 6. Generate and store keypair (if not already generated)
        final hasKeypair = await _keyService.hasKeypair();
        final pubkeyHex = hasKeypair
            ? (await _keyService.getPublicKeyHex())!
            : await _keyService.generateAndStoreKeypair();

        // 7. Scaffold Koinon repo
        final client = await _gitService.getClient();
        final repoName = 'koinon';
        final repoHttps =
            '${credentials.baseUrl}/${credentials.username}/$repoName';

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
      'connectViaOAuth',
    );
  }
}
