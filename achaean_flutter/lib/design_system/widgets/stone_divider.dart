import 'package:flutter/material.dart';
import '../primitives/app_palette.dart';
import '../primitives/app_sizes.dart';
import '../theme/theme_service.dart';
import 'package:get_it/get_it.dart';

/// Horizontal stone divider — the primary content separator.
///
/// Use instead of Material Divider. Renders as a single line in
/// weathered stone color with consistent vertical spacing.
class StoneDivider extends StatelessWidget {
  /// Vertical padding above and below the line.
  final double? verticalPadding;

  /// Horizontal indent from edges.
  final double? indent;

  const StoneDivider({
    super.key,
    this.verticalPadding,
    this.indent,
  });

  @override
  Widget build(BuildContext context) {
    final palette = GetIt.instance<ThemeService>().currentPalette;
    final vPad = verticalPadding ?? AppSizes.space;
    final hIndent = indent ?? 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: hIndent),
        height: AppSizes.borderWidth,
        color: palette.textSecondary.withValues(alpha: 0.3),
      ),
    );
  }
}
