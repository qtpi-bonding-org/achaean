import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_account_creation_service.dart';
import 'account_creation_state.dart';

class AccountCreationCubit extends AppCubit<AccountCreationState> {
  final IAccountCreationService _service;

  AccountCreationCubit(this._service)
      : super(const AccountCreationState());

  /// Run the full OAuth flow: opens browser, exchanges code, scaffolds repo.
  Future<void> connectAccount(String serverUrl) async {
    final normalized = _normalizeUrl(serverUrl);
    await tryOperation(
      () async {
        final result = await _service.connectViaOAuth(
          serverUrl: normalized,
        );
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Open the git server's signup page in the browser.
  Future<void> openSignupPage(String serverUrl) async {
    final normalized = _normalizeUrl(serverUrl);
    await launchUrl(
      Uri.parse('$normalized/user/sign_up'),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Normalize URL: trim, ensure https:// prefix, remove trailing slash.
  String _normalizeUrl(String url) {
    var normalized = url.trim();
    if (!normalized.startsWith('http://') &&
        !normalized.startsWith('https://')) {
      normalized = 'https://$normalized';
    }
    if (normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return normalized;
  }
}
