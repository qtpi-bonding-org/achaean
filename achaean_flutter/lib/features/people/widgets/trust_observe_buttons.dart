// achaean_flutter/lib/features/people/widgets/trust_observe_buttons.dart
import 'package:flutter/material.dart';

import '../../../design_system/primitives/app_sizes.dart';
import '../../../l10n/app_localizations.dart';

/// Row of Trust and Observe toggle buttons for the user detail screen.
///
/// Trust button shows a confirmation dialog before activating.
/// Observe button toggles instantly.
class TrustObserveButtons extends StatelessWidget {
  final bool isTrusted;
  final bool isObserving;
  final bool isLoading;
  final VoidCallback onTrustPressed;
  final VoidCallback onObservePressed;

  const TrustObserveButtons({
    super.key,
    required this.isTrusted,
    required this.isObserving,
    required this.isLoading,
    required this.onTrustPressed,
    required this.onObservePressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: _ToggleButton(
            label: isTrusted ? l10n.trustedLabel : l10n.trustButton,
            isActive: isTrusted,
            isLoading: isLoading,
            onPressed: onTrustPressed,
            theme: theme,
          ),
        ),
        SizedBox(width: AppSizes.space),
        Expanded(
          child: _ToggleButton(
            label: isObserving ? l10n.observingLabel : l10n.observeButton,
            isActive: isObserving,
            isLoading: isLoading,
            onPressed: onObservePressed,
            theme: theme,
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isLoading;
  final VoidCallback onPressed;
  final ThemeData theme;

  const _ToggleButton({
    required this.label,
    required this.isActive,
    required this.isLoading,
    required this.onPressed,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: Text(label),
      );
    }
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: Text(label),
    );
  }
}
