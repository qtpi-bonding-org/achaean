import 'package:achaean_client/achaean_client.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/url_utils.dart';
import '../../../design_system/widgets/inscription_tile.dart';

/// A feed tile showing post metadata from a [PostReference].
///
/// Line 1: author · relative time · polis tag
/// Line 2: title, "Replying to {user}", or blank
///
/// Tap the leading person icon to navigate to the author's user detail screen.
class PostReferenceTile extends StatelessWidget {
  final PostReference postRef;
  final VoidCallback? onTap;
  final VoidCallback? onAuthorTap;

  const PostReferenceTile({
    super.key,
    required this.postRef,
    this.onTap,
    this.onAuthorTap,
  });

  @override
  Widget build(BuildContext context) {
    final author = usernameFromRepoUrl(postRef.authorRepoUrl);
    final time = relativeTime(postRef.timestamp);
    final polis = firstPolisTag(postRef.poleisTags);

    final metadataLine = [
      author,
      time,
      ?polis,
    ].join(' · ');

    final contextLine = _buildContextLine();

    return InscriptionTile(
      leading: GestureDetector(
        onTap: onAuthorTap,
        child: const Icon(Icons.person_outline),
      ),
      title: metadataLine,
      subtitle: contextLine,
      onTap: onTap,
    );
  }

  String? _buildContextLine() {
    if (postRef.parentPostUrl != null) {
      final parentAuthor = usernameFromPostUrl(postRef.parentPostUrl!);
      return 'Replying to $parentAuthor';
    }
    return postRef.title;
  }
}
