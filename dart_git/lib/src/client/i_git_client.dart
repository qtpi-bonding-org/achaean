import '../models/git_commit.dart';
import '../models/git_directory_entry.dart';
import '../models/git_file.dart';
import '../models/git_repo.dart';

/// Abstract interface for Git hosting provider operations.
abstract class IGitClient {
  Future<GitRepo> createRepo({
    required String name,
    String? description,
    bool private = false,
  });

  Future<void> deleteRepo({
    required String owner,
    required String repo,
  });

  Future<GitCommit> commitFile({
    required String owner,
    required String repo,
    required String path,
    required String content,
    required String message,
    String? sha,
    String? branch,
  });

  Future<GitFile> readFile({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  });

  Future<List<GitDirectoryEntry>> listFiles({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  });

  Future<void> deleteFile({
    required String owner,
    required String repo,
    required String path,
    required String sha,
    required String message,
    String? branch,
  });

  Future<bool> exists({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  });
}
