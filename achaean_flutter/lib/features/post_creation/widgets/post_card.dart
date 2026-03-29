import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';

import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/theme/app_theme.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.space * 2,
        vertical: AppSizes.space / 2,
      ),
      padding: EdgeInsets.all(AppSizes.space * 2),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: context.colorScheme.tertiary.withValues(alpha: 0.2),
          width: AppSizes.borderWidth,
        ),
        // Inset shadow — inscribed tablet effect
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.tertiary.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.content.title != null)
            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.space),
              child: Text(
                post.content.title!,
                style: context.textTheme.titleMedium,
              ),
            ),
          Text(
            post.content.text,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: AppSizes.space),
          Text(
            post.timestamp.toLocal().toString().split('.').first,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
