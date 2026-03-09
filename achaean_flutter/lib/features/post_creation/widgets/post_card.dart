import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';

import '../../../design_system/primitives/app_sizes.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.space * 2,
        vertical: AppSizes.space / 2,
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.space * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.content.title != null)
              Padding(
                padding: EdgeInsets.only(bottom: AppSizes.space),
                child: Text(
                  post.content.title!,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            Text(
              post.content.text,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: AppSizes.space),
            Text(
              post.timestamp.toLocal().toString().split('.').first,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
