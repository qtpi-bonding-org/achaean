/// Author/committer identity for git commits.
class GitAuthor {
  final String name;
  final String email;

  const GitAuthor({required this.name, required this.email});

  Map<String, String> toJson() => {'name': name, 'email': email};
}
