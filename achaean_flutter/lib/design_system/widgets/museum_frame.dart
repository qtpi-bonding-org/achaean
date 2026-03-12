import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Stone border frame for displaying user-authored rich content.
///
/// Wraps HTML/rich content in a museum-style frame — the building
/// is consistent stone, the art inside is the author's. Use for
/// [RichReadablePost] content rendered in a webview.
class MuseumFrame extends StatelessWidget with AccessibleWidget {
  final Widget child;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const MuseumFrame({
    super.key,
    required this.child,
    this.decorative = true,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return buildAccessible(child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.tertiary.withValues(alpha: 0.4),
          width: AppSizes.borderWidthThick,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
        child: child,
      ),
    ));
  }
}
