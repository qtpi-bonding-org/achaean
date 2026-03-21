/// Extracts the username (repo owner) from a repo URL.
///
/// e.g. `https://forge.example/alice/koinon` → `alice`
String usernameFromRepoUrl(String repoUrl) {
  final uri = Uri.parse(repoUrl);
  final segments = uri.pathSegments;
  return segments.isNotEmpty ? segments.first : repoUrl;
}

/// Extracts the username from a full post URL.
///
/// e.g. `https://forge.example/bob/koinon/posts/hello/post.json` → `bob`
String usernameFromPostUrl(String postUrl) {
  final uri = Uri.parse(postUrl);
  final segments = uri.pathSegments;
  return segments.isNotEmpty ? segments.first : postUrl;
}

/// Formats a timestamp as relative time (e.g. "2h ago", "3d ago").
String relativeTime(DateTime timestamp) {
  final now = DateTime.now();
  final diff = now.difference(timestamp);

  if (diff.inSeconds < 60) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 30) return '${diff.inDays}d ago';
  if (diff.inDays < 365) return '${diff.inDays ~/ 30}mo ago';
  return '${diff.inDays ~/ 365}y ago';
}

/// Extracts the first polis tag from a comma-separated poleisTags string.
///
/// Returns the polis name (last path segment of the URL), or null if empty.
/// e.g. `https://forge.example/alice/polis-democracy,https://...` → `polis-democracy`
String? firstPolisTag(String? poleisTags) {
  if (poleisTags == null || poleisTags.isEmpty) return null;
  final first = poleisTags.split(',').first.trim();
  if (first.isEmpty) return null;
  final uri = Uri.tryParse(first);
  if (uri != null && uri.pathSegments.length >= 2) {
    return uri.pathSegments.last;
  }
  return first;
}
