import 'package:flutter/material.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

/// Simple loading service that tracks loading state.
/// On web/mobile, loading is handled by individual screen states,
/// so this is a no-op implementation that satisfies the contract.
class AppLoadingService implements ILoadingService {
  @override
  void show() {
    // Loading is handled by BlocBuilder in individual screens
  }

  @override
  void hide() {
    // Loading is handled by BlocBuilder in individual screens
  }
}

/// Feedback service that prints to debug console.
/// TODO: Replace with snackbar/toast implementation when a global scaffold key is available.
class AppFeedbackService implements IFeedbackService {
  @override
  void show(FeedbackMessage message) {
    debugPrint('[${message.type.name}] ${message.message}');
  }
}

/// Localization service that passes through keys as-is.
/// Actual l10n is handled by Flutter's built-in AppLocalizations.
class AppLocalizationService implements ILocalizationService {
  @override
  String translate(String key, {Map<String, dynamic>? args}) {
    // Keys are already human-readable from the mappers
    return key;
  }
}
