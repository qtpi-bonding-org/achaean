import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Primary action button — filled terracotta with limestone text.
///
/// Use for the single primary action on a screen. For secondary actions,
/// use [FlatTextButton] instead. Never use FABs or outline buttons.
class TerracottaButton extends StatelessWidget with AccessibleWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const TerracottaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return buildAccessible(child: SizedBox(
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
    ));
  }
}
