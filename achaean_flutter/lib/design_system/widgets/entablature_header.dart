import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';
import 'stone_divider.dart';

/// Section header with Cinzel title, optional subtitle, and stone divider below.
///
/// Use to mark major content sections. The title renders in Cinzel (via
/// headlineMedium), the subtitle in League Spartan (via bodyMedium).
class EntablatureHeader extends StatelessWidget with AccessibleWidget {
  final String title;
  final String? subtitle;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const EntablatureHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return buildAccessible(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        if (subtitle != null) ...[
          SizedBox(height: AppSizes.space * 0.5),
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.tertiary,
            ),
          ),
        ],
        const StoneDivider(),
      ],
    ));
  }
}
