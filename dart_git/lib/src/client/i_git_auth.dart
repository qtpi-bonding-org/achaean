/// Authentication strategy for Git API clients.
abstract class IGitAuth {
  Map<String, String> get headers;
}

/// Token-based authentication (e.g. personal access tokens).
class GitTokenAuth implements IGitAuth {
  final String token;

  const GitTokenAuth(this.token);

  @override
  Map<String, String> get headers => {'Authorization': 'token $token'};
}

/// No-auth strategy for reading public repos.
class GitPublicAuth implements IGitAuth {
  const GitPublicAuth();

  @override
  Map<String, String> get headers => {};
}
