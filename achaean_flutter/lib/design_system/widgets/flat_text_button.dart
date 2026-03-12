import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Secondary action button — text only, no background or border.
///
/// Use for secondary or tertiary actions. Set [isPrimary] to true
/// for terracotta text (more emphasis), false for charcoal text (less).
class FlatTextButton extends StatelessWidget with AccessibleWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const FlatTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = false,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return buildAccessible(child: TextButton(
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
    ));
  }
}
