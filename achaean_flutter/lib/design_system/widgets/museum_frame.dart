import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Stone border frame for displaying user-authored rich content.
///
/// Wraps HTML/rich content in a museum-style frame — the building
/// is consistent stone, the art inside is the author's. Use for
/// [RichReadablePost] content rendered in a webview.
class MuseumFrame extends StatelessWidget {
  final Widget child;

  const MuseumFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
