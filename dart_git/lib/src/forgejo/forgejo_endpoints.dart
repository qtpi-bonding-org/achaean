/// URL builder for Forgejo API v1 endpoints.
class ForgejoEndpoints {
  final String baseUrl;

  const ForgejoEndpoints(this.baseUrl);

  String _api(String path) => '$baseUrl/api/v1$path';

  /// POST /api/v1/user/repos
  Uri createRepo() => Uri.parse(_api('/user/repos'));

  /// DELETE /api/v1/repos/{owner}/{repo}
  Uri deleteRepo(String owner, String repo) =>
      Uri.parse(_api('/repos/$owner/$repo'));

  /// GET/POST/PUT /api/v1/repos/{owner}/{repo}/contents/{path}
  Uri contents(String owner, String repo, String path, {String? ref}) {
    final uri = Uri.parse(_api('/repos/$owner/$repo/contents/$path'));
    if (ref != null) {
      return uri.replace(queryParameters: {'ref': ref});
    }
    return uri;
  }

  /// DELETE /api/v1/repos/{owner}/{repo}/contents/{path}
  Uri deleteContents(String owner, String repo, String path) =>
      Uri.parse(_api('/repos/$owner/$repo/contents/$path'));

  /// POST /api/v1/repos/{owner}/{repo}/forks
  Uri forkRepo(String owner, String repo) =>
      Uri.parse(_api('/repos/$owner/$repo/forks'));
}
