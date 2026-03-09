import 'dart:convert';

import 'package:http/http.dart' as http;

import '../client/git_exception.dart';
import '../client/i_git_auth.dart';
import '../client/i_git_client.dart';
import '../models/git_commit.dart';
import '../models/git_directory_entry.dart';
import '../models/git_file.dart';
import '../models/git_repo.dart';
import 'forgejo_endpoints.dart';

/// Forgejo implementation of [IGitClient].
class ForgejoClient implements IGitClient {
  final IGitAuth auth;
  final ForgejoEndpoints endpoints;
  final http.Client httpClient;

  ForgejoClient({
    required String baseUrl,
    required this.auth,
    http.Client? httpClient,
  })  : endpoints = ForgejoEndpoints(baseUrl),
        httpClient = httpClient ?? http.Client();

  Map<String, String> get _headers => {
        ...auth.headers,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Never _throw(http.Response response) {
    final msg = 'HTTP ${response.statusCode}';
    switch (response.statusCode) {
      case 401 || 403:
        throw GitUnauthorizedException(msg,
            statusCode: response.statusCode, body: response.body);
      case 404:
        throw GitNotFoundException(msg,
            statusCode: response.statusCode, body: response.body);
      case 409:
        throw GitConflictException(msg,
            statusCode: response.statusCode, body: response.body);
      case 429:
        throw GitRateLimitException(msg,
            statusCode: response.statusCode, body: response.body);
      default:
        throw GitUnexpectedException(msg,
            statusCode: response.statusCode, body: response.body);
    }
  }

  Map<String, dynamic> _decodeJson(http.Response response) =>
      jsonDecode(response.body) as Map<String, dynamic>;

  @override
  Future<GitRepo> createRepo({
    required String name,
    String? description,
    bool private = false,
  }) async {
    final response = await httpClient.post(
      endpoints.createRepo(),
      headers: _headers,
      body: jsonEncode({
        'name': name,
        if (description != null) 'description': description,
        'private': private,
        'auto_init': true,
      }),
    );
    if (response.statusCode != 201) _throw(response);
    final json = _decodeJson(response);
    return GitRepo(
      id: json['id'] as int,
      name: json['name'] as String,
      owner: (json['owner'] as Map<String, dynamic>)['login'] as String,
      cloneUrl: json['clone_url'] as String,
      htmlUrl: json['html_url'] as String,
      description: json['description'] as String?,
      private: json['private'] as bool? ?? false,
    );
  }

  @override
  Future<void> deleteRepo({
    required String owner,
    required String repo,
  }) async {
    final response = await httpClient.delete(
      endpoints.deleteRepo(owner, repo),
      headers: _headers,
    );
    if (response.statusCode != 204) _throw(response);
  }

  @override
  Future<GitCommit> commitFile({
    required String owner,
    required String repo,
    required String path,
    required String content,
    required String message,
    String? sha,
    String? branch,
  }) async {
    final encoded = base64Encode(utf8.encode(content));
    final body = <String, dynamic>{
      'content': encoded,
      'message': message,
      if (sha != null) 'sha': sha,
      if (branch != null) 'branch': branch,
    };

    final uri = endpoints.contents(owner, repo, path);
    final http.Response response;

    if (sha != null) {
      // Update existing file
      response = await httpClient.put(uri, headers: _headers, body: jsonEncode(body));
    } else {
      // Create new file
      response = await httpClient.post(uri, headers: _headers, body: jsonEncode(body));
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      _throw(response);
    }

    final json = _decodeJson(response);
    final commit = json['commit'] as Map<String, dynamic>;
    return GitCommit(
      sha: commit['sha'] as String,
      message: commit['message'] as String,
      timestamp: DateTime.parse(
          (commit['author'] as Map<String, dynamic>)['date'] as String),
    );
  }

  @override
  Future<GitFile> readFile({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  }) async {
    final response = await httpClient.get(
      endpoints.contents(owner, repo, path, ref: ref),
      headers: _headers,
    );
    if (response.statusCode != 200) _throw(response);
    final json = _decodeJson(response);
    final encoded = (json['content'] as String).replaceAll('\n', '');
    return GitFile(
      path: json['path'] as String,
      content: utf8.decode(base64Decode(encoded)),
      sha: json['sha'] as String,
    );
  }

  @override
  Future<List<GitDirectoryEntry>> listFiles({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  }) async {
    final response = await httpClient.get(
      endpoints.contents(owner, repo, path, ref: ref),
      headers: _headers,
    );
    if (response.statusCode != 200) _throw(response);
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((item) {
      final entry = item as Map<String, dynamic>;
      return GitDirectoryEntry(
        name: entry['name'] as String,
        path: entry['path'] as String,
        type: entry['type'] == 'dir' ? GitEntryType.dir : GitEntryType.file,
      );
    }).toList();
  }

  @override
  Future<void> deleteFile({
    required String owner,
    required String repo,
    required String path,
    required String sha,
    required String message,
    String? branch,
  }) async {
    final response = await httpClient.delete(
      endpoints.deleteContents(owner, repo, path),
      headers: _headers,
      body: jsonEncode({
        'sha': sha,
        'message': message,
        if (branch != null) 'branch': branch,
      }),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      _throw(response);
    }
  }

  @override
  Future<bool> exists({
    required String owner,
    required String repo,
    required String path,
    String? ref,
  }) async {
    final response = await httpClient.get(
      endpoints.contents(owner, repo, path, ref: ref),
      headers: _headers,
    );
    return response.statusCode == 200;
  }
}
