import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../../../core/exceptions/account_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/services/secure_preferences.dart';
import '../../../core/try_operation.dart';
import '../models/account_creation_result.dart';
import 'i_account_creation_service.dart';

class AccountCreationService implements IAccountCreationService {
  final IKeyService _keyService;
  final IGitOAuth _oauth;
  final IGitService _gitService;
  final SecurePreferences _prefs;

  AccountCreationService(this._keyService, this._oauth, this._gitService, this._prefs);

  @override
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    required String indexServerUrl,
    String callbackUrlScheme = 'achaean',
  }) {
    return tryMethod(
      () async {
        // 0. Store index server URL
        await _prefs.setIndexServerUrl(indexServerUrl);

        // On web, flutter_web_auth_2 uses a popup that redirects to /auth.html
        // The redirect URI must use the current origin, not a custom scheme.
        final redirectUri = kIsWeb
            ? Uri.base.resolve('auth.html').toString()
            : '$callbackUrlScheme://oauth-callback';
        final webCallbackScheme = kIsWeb
            ? 'http'
            : callbackUrlScheme;

        debugPrint('OAuth: kIsWeb=$kIsWeb');
        debugPrint('OAuth: Uri.base=${Uri.base}');
        debugPrint('OAuth: redirectUri=$redirectUri');
        debugPrint('OAuth: callbackUrlScheme=$webCallbackScheme');

        // 1. Build OAuth URL with PKCE
        final authResult = _oauth.buildAuthorizationUrl(
          serverUrl: serverUrl,
          redirectUri: redirectUri,
        );

        debugPrint('OAuth: authUrl=${authResult.url}');

        // 2. Open browser and wait for redirect
        debugPrint('OAuth: calling FlutterWebAuth2.authenticate...');
        String resultUrl;
        try {
          resultUrl = await FlutterWebAuth2.authenticate(
            url: authResult.url,
            callbackUrlScheme: webCallbackScheme,
          );
          debugPrint('OAuth: resultUrl=$resultUrl');
        } catch (e, stack) {
          debugPrint('OAuth: FlutterWebAuth2 error: $e');
          debugPrint('OAuth: stack: $stack');
          rethrow;
        }

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

        debugPrint('OAuth: code=$code');
        debugPrint('OAuth: state match=${returnedState == authResult.state}');

        // 4. Exchange code for credentials
        debugPrint('OAuth: exchanging code at $serverUrl ...');
        late final GitCredentials credentials;
        try {
          credentials = await _oauth.exchangeCode(
            serverUrl: serverUrl,
            code: code,
            codeVerifier: authResult.codeVerifier,
            redirectUri: redirectUri,
          );
          debugPrint('OAuth: credentials received — user=${credentials.username} host=${credentials.hostType}');
        } catch (e, stack) {
          debugPrint('OAuth: exchangeCode FAILED: $e');
          debugPrint('OAuth: stack: $stack');
          rethrow;
        }

        // 5. Configure git service with OAuth credentials (bearer auth)
        debugPrint('OAuth: configuring git service...');
        await _gitService.configure(
          baseUrl: credentials.baseUrl,
          token: credentials.token,
          username: credentials.username,
          hostType: credentials.hostType,
          authType: 'bearer',
        );

        debugPrint('OAuth: git service configured');

        // 6. Generate and store keypair (if not already generated)
        debugPrint('OAuth: checking keypair...');
        final hasKeypair = await _keyService.hasKeypair();
        debugPrint('OAuth: hasKeypair=$hasKeypair');
        final pubkeyHex = hasKeypair
            ? (await _keyService.getPublicKeyHex())!
            : await _keyService.generateAndStoreKeypair();
        debugPrint('OAuth: pubkey=${pubkeyHex.substring(0, 16)}...');

        // 7. Scaffold Koinon repo
        debugPrint('OAuth: scaffolding koinon repo...');
        final client = await _gitService.getClient();
        final repoName = 'koinon';
        final repoHttps =
            '${credentials.baseUrl}/${credentials.username}/$repoName';
        debugPrint('OAuth: repoHttps=$repoHttps');

        final repo = await RepoScaffolder(client).scaffold(
          repoName: repoName,
          pubkey: pubkeyHex,
          repoHttps: repoHttps,
        );
        debugPrint('OAuth: repo scaffolded — ${repo.htmlUrl}');

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
