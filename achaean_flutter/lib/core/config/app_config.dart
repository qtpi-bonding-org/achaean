/// Build-time configuration from --dart-define flags.
class AppConfig {
  AppConfig._();

  /// The repo URL for guest/demo mode. Empty string if not configured.
  static const guestRepoUrl = String.fromEnvironment('GUEST_REPO_URL');

  /// Whether guest mode is available (GUEST_REPO_URL was provided at build time).
  static bool get hasGuestMode => guestRepoUrl.isNotEmpty;
}
