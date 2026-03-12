import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';
import 'stone_divider.dart';

/// Universal list row — title, optional subtitle, optional trailing element.
///
/// Separated by [StoneDivider] below. Use for posts, poleis, members,
/// trust declarations — any content that appears in a vertical list.
/// Do not wrap in cards.
class InscriptionTile extends StatelessWidget with AccessibleWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const InscriptionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.showDivider = true,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return buildAccessible(child: Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.space * 2,
              vertical: AppSizes.space * 1.5,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: AppSizes.space * 1.5),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.titleSmall,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: AppSizes.space * 0.5),
                        Text(
                          subtitle!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: AppSizes.space),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
        if (showDivider)
          StoneDivider(
            verticalPadding: 0,
            indent: AppSizes.space * 2,
          ),
      ],
    ));
  }
}
