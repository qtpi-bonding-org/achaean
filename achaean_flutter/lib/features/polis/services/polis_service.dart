import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:yaml/yaml.dart';

import '../../../core/exceptions/polis_exception.dart';
import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_signing_service.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart';
import 'i_polis_service.dart';

class PolisService implements IPolisService {
  final IGitService _gitService;
  final ISigningService _signingService;
  final PublicGitClientFactory _publicClientFactory;

  PolisService(
    this._gitService,
    this._signingService,
    this._publicClientFactory,
  );

  @override
  Future<RepoIdentifier> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );
        final baseUrl = requireNonNull(
          await _gitService.getBaseUrl(),
          'baseUrl',
          PolisException.new,
        );

        // Slugify polis name for repo
        final repoName =
            'polis-${name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '')}';

        // 1. Create polis repo
        await client.createRepo(name: repoName);

        // 2. Build README with YAML frontmatter
        final frontmatter = StringBuffer('---\n');
        frontmatter.writeln('name: "$name"');
        if (description != null) {
          frontmatter.writeln('description: "$description"');
        }
        if (norms != null) frontmatter.writeln('norms: "$norms"');
        if (threshold != null) frontmatter.writeln('threshold: $threshold');
        frontmatter.writeln('---\n');
        frontmatter.writeln('# $name');
        if (description != null) frontmatter.writeln('\n$description');

        final readmeContent = frontmatter.toString();

        // 3. Commit README
        final readmeCommit = await client.commitFile(
          owner: owner,
          repo: repoName,
          path: 'README.md',
          content: readmeContent,
          message: 'Initialize polis: $name',
        );

        // 4. Sign README → commit signature to own koinon repo
        final readmeHash = _computeContentHash(readmeContent);
        final repoId = RepoIdentifier(
          baseUrl: baseUrl,
          owner: owner,
          repo: repoName,
        );
        final repoIdString = '${repoId.owner}/${repoId.repo}';

        final readmeSig = ReadmeSignature(
          polis: repoIdString,
          readmeCommit: readmeCommit.sha,
          readmeHash: readmeHash,
          timestamp: DateTime.now().toUtc(),
          signature: '',
        );
        final signature = await _signingService.sign(readmeSig.toJson());
        final signedSig = readmeSig.copyWith(signature: signature);

        final sigPath = 'poleis/$repoIdString/signature.json';
        final sigJson =
            const JsonEncoder.withIndent('  ').convert(signedSig.toJson());

        await client.commitFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
          content: sigJson,
          message: 'Sign polis README: $name',
        );

        // 5. Update koinon.json poleis list
        await _addPolisToManifest(client, owner, repoIdString, name);

        return repoId;
      },
      PolisException.new,
      'createPolis',
    );
  }

  @override
  Future<void> joinPolis(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          PolisException.new,
        );

        // 1. Read polis README via public client
        final publicClient = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        final readmeFile = await publicClient.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: 'README.md',
        );

        // 2. Compute content hash and build signature
        final readmeHash = _computeContentHash(readmeFile.content);
        final repoIdString = '${repoId.owner}/${repoId.repo}';

        // 3. Sign README
        final readmeSig = ReadmeSignature(
          polis: repoIdString,
          readmeCommit: readmeFile.sha,
          readmeHash: readmeHash,
          timestamp: DateTime.now().toUtc(),
          signature: '',
        );
        final signature = await _signingService.sign(readmeSig.toJson());
        final signedSig = readmeSig.copyWith(signature: signature);

        // 4. Commit signature to own repo
        final sigPath = 'poleis/$repoIdString/signature.json';
        final sigJson =
            const JsonEncoder.withIndent('  ').convert(signedSig.toJson());

        // Check if already exists (re-joining)
        String? existingSha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: 'koinon',
            path: sigPath,
          );
          existingSha = existing.sha;
        } on GitNotFoundException {
          // New join
        }

        await client.commitFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
          content: sigJson,
          message: 'Join polis: $repoIdString',
          sha: existingSha,
        );

        // 5. Parse polis name from README frontmatter
        final info = _parseYamlFrontmatter(readmeFile.content);

        // 6. Update koinon.json
        await _addPolisToManifest(client, owner, repoIdString, info.name);
      },
      PolisException.new,
      'joinPolis',
    );
  }

  @override
  Future<void> leavePolis(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );
        final repoIdString = '${repoId.owner}/${repoId.repo}';

        // 1. Delete signature file
        final sigPath = 'poleis/$repoIdString/signature.json';
        final file = await client.readFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
        );
        await client.deleteFile(
          owner: owner,
          repo: 'koinon',
          path: sigPath,
          sha: file.sha,
          message: 'Leave polis: $repoIdString',
        );

        // 2. Update koinon.json — remove polis entry
        await _removePolisFromManifest(client, owner, repoIdString);
      },
      PolisException.new,
      'leavePolis',
    );
  }

  @override
  Future<PolisInfo> getPolisInfo(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          PolisException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );

        final readmeFile = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: 'README.md',
        );

        return _parseYamlFrontmatter(readmeFile.content);
      },
      PolisException.new,
      'getPolisInfo',
    );
  }

  @override
  Future<List<PolisMembership>> getOwnPoleis() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          PolisException.new,
        );

        final file = await client.readFile(
          owner: owner,
          repo: 'koinon',
          path: '.well-known/koinon.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(json);
        return manifest.poleis;
      },
      PolisException.new,
      'getOwnPoleis',
    );
  }

  // --- Private helpers ---

  PolisInfo _parseYamlFrontmatter(String readmeContent) {
    final lines = readmeContent.split('\n');
    if (lines.isEmpty || lines.first.trim() != '---') {
      throw const PolisException('README has no YAML frontmatter');
    }

    final endIndex = lines.indexWhere(
      (l) => l.trim() == '---',
      1, // skip opening ---
    );
    if (endIndex == -1) {
      throw const PolisException('README frontmatter not closed');
    }

    final yamlStr = lines.sublist(1, endIndex).join('\n');
    final yaml = loadYaml(yamlStr) as YamlMap;

    return PolisInfo(
      name: yaml['name'] as String? ?? 'Unknown',
      description: yaml['description'] as String?,
      norms: yaml['norms'] as String?,
      threshold: yaml['threshold'] as int?,
      parentRepo: yaml['parent_repo'] as String?,
    );
  }

  String _computeContentHash(String content) {
    return base64Url.encode(utf8.encode(content)).replaceAll('=', '');
  }

  Future<void> _addPolisToManifest(
    IGitClient client,
    String owner,
    String repoIdString,
    String polisName,
  ) async {
    final manifestFile = await client.readFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
    );
    final manifestJson =
        jsonDecode(manifestFile.content) as Map<String, dynamic>;
    final manifest = KoinonManifest.fromJson(manifestJson);

    // Check if already a member
    if (manifest.poleis.any((p) => p.repo == repoIdString)) return;

    final updated = manifest.copyWith(
      poleis: [
        ...manifest.poleis,
        PolisMembership(
          repo: repoIdString,
          name: polisName,
          stars: 1,
          role: 'member',
        ),
      ],
    );

    final updatedJson =
        const JsonEncoder.withIndent('  ').convert(updated.toJson());
    await client.commitFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
      content: updatedJson,
      message: 'Add polis membership: $polisName',
      sha: manifestFile.sha,
    );
  }

  Future<void> _removePolisFromManifest(
    IGitClient client,
    String owner,
    String repoIdString,
  ) async {
    final manifestFile = await client.readFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
    );
    final manifestJson =
        jsonDecode(manifestFile.content) as Map<String, dynamic>;
    final manifest = KoinonManifest.fromJson(manifestJson);

    final updated = manifest.copyWith(
      poleis: manifest.poleis.where((p) => p.repo != repoIdString).toList(),
    );

    final updatedJson =
        const JsonEncoder.withIndent('  ').convert(updated.toJson());
    await client.commitFile(
      owner: owner,
      repo: 'koinon',
      path: '.well-known/koinon.json',
      content: updatedJson,
      message: 'Remove polis membership: $repoIdString',
      sha: manifestFile.sha,
    );
  }
}
