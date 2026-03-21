import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/url_utils.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/museum_frame.dart';
import '../services/post_content_cache.dart';

class PostDetailScreen extends StatefulWidget {
  final PostReference postRef;
  final PostContentCache contentCache;

  const PostDetailScreen({
    super.key,
    required this.postRef,
    required this.contentCache,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  ReadablePostContent? _content;
  bool _loading = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final cached = widget.contentCache.get(widget.postRef.postUrl);
    if (cached != null) {
      setState(() => _content = cached);
      return;
    }

    setState(() => _loading = true);
    try {
      final content =
          await widget.contentCache.getOrFetch(widget.postRef);
      if (mounted) setState(() => _content = content);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ref = widget.postRef;
    final author = usernameFromRepoUrl(ref.authorRepoUrl);
    final polis = firstPolisTag(ref.poleisTags);

    return AchaeanScaffold(
      title: ref.title ?? 'Post',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.space * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$author · ${ref.timestamp.toLocal().toString().split('.').first}',
              style: theme.textTheme.bodySmall,
            ),

            if (polis != null) ...[
              SizedBox(height: AppSizes.space * 0.5),
              Text(
                polis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],

            if (ref.parentPostUrl != null) ...[
              SizedBox(height: AppSizes.space * 0.5),
              Text(
                'Replying to ${usernameFromPostUrl(ref.parentPostUrl!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            SizedBox(height: AppSizes.space * 2),

            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(
                'Failed to load post content',
                style: theme.textTheme.bodyMedium,
              )
            else if (_content != null)
              _buildContent(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    final content = _content!;

    return switch (content) {
      RichReadablePost(:final post, :final html, :final css) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.content.title != null) ...[
              Text(post.content.title!, style: theme.textTheme.headlineSmall),
              SizedBox(height: AppSizes.space),
            ],
            MuseumFrame(child: _buildWebView(html, css)),
          ],
        ),
      JsonReadablePost(:final post) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.content.title != null) ...[
              Text(post.content.title!, style: theme.textTheme.headlineSmall),
              SizedBox(height: AppSizes.space),
            ],
            Text(post.content.text, style: theme.textTheme.bodyMedium),
          ],
        ),
    };
  }

  Widget _buildWebView(String html, String? css) {
    return Text(html);
  }
}
