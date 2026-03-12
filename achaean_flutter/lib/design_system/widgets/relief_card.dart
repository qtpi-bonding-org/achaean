import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Subtle card with stone border — use sparingly.
///
/// For when content needs grouping (post previews, profile headers).
/// No shadow, no elevation. Slight surface color shift with a thin
/// stone-colored border. Prefer [InscriptionTile] + [StoneDivider]
/// for lists.
class ReliefCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const ReliefCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.all(AppSizes.space * 2),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: context.colorScheme.tertiary.withValues(alpha: 0.2),
          width: AppSizes.borderWidth,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}
