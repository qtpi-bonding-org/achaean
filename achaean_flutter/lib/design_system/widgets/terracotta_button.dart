import 'package:flutter/material.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Primary action button — filled terracotta with limestone text.
///
/// Use for the single primary action on a screen. For secondary actions,
/// use [FlatTextButton] instead. Never use FABs or outline buttons.
class TerracottaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const TerracottaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        height: AppSizes.buttonHeight,
        width: double.infinity,
        child: FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
            ),
            textStyle: TextStyle(
              fontFamily: AppFonts.bodyFamily,
              fontSize: AppSizes.fontStandard,
              fontWeight: AppFonts.medium,
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: AppSizes.iconMedium,
                  width: AppSizes.iconMedium,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.onPrimary,
                  ),
                )
              : Text(label),
        ),
      ),
    );
  }
}
