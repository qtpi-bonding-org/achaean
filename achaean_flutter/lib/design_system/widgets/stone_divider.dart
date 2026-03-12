import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_sizes.dart';

/// Horizontal stone divider — the primary content separator.
///
/// Use instead of Material Divider. Renders as a single line in
/// weathered stone color with consistent vertical spacing.
class StoneDivider extends StatelessWidget with AccessibleWidget {
  /// Vertical padding above and below the line.
  final double? verticalPadding;

  /// Horizontal indent from edges.
  final double? indent;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const StoneDivider({
    super.key,
    this.verticalPadding,
    this.indent,
    this.decorative = true,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final vPad = verticalPadding ?? AppSizes.space;
    final hIndent = indent ?? 0.0;

    return buildAccessible(child: Padding(
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: hIndent),
        height: AppSizes.borderWidth,
        color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
      ),
    ));
  }
}
