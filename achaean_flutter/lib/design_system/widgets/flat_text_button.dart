import 'package:flutter/material.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Secondary action button — text only, no background or border.
///
/// Use for secondary or tertiary actions. Set [isPrimary] to true
/// for terracotta text (more emphasis), false for charcoal text (less).
class FlatTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const FlatTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: label,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor:
              isPrimary ? colorScheme.primary : colorScheme.onSurface,
          textStyle: TextStyle(
            fontFamily: AppFonts.bodyFamily,
            fontSize: AppSizes.fontStandard,
            fontWeight: AppFonts.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
