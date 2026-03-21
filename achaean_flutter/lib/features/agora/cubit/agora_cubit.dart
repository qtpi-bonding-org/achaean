import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_agora_service.dart';
import '../services/i_polis_query_service.dart';
import 'agora_state.dart';

class AgoraCubit extends AppCubit<AgoraState> {
  final IAgoraService _agoraService;
  final IPolisQueryService _polisQueryService;

  String? _currentPolisRepoUrl;
  static const _pageSize = 50;

  AgoraCubit(this._agoraService, this._polisQueryService)
      : super(const AgoraState());

  /// Load the agora for a polis.
  Future<void> loadAgora(String polisRepoUrl) async {
    _currentPolisRepoUrl = polisRepoUrl;

    await tryOperation(
      () async {
        final polis = await _polisQueryService.getPolis(polisRepoUrl);
        final threshold = polis?.flagThreshold ?? 1;

        final results = await Future.wait([
          _agoraService.getAgoraRefs(polisRepoUrl, limit: _pageSize, offset: 0),
          _agoraService.getFlagsForPolis(polisRepoUrl),
        ]);

        final posts = results[0] as List<PostReference>;
        final flags = results[1] as List<FlagRecord>;

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          flagCounts: _computeFlagCounts(flags),
          flagThreshold: threshold,
          hasMore: posts.length >= _pageSize,
          offset: posts.length,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Load more posts (pagination).
  Future<void> loadMore() async {
    final polisRepoUrl = _currentPolisRepoUrl;
    if (polisRepoUrl == null || !state.hasMore) return;

    await tryOperation(
      () async {
        final morePosts = await _agoraService.getAgoraRefs(
          polisRepoUrl,
          limit: _pageSize,
          offset: state.offset,
        );

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: [...state.posts, ...morePosts],
          hasMore: morePosts.length >= _pageSize,
          offset: state.offset + morePosts.length,
          error: null,
        );
      },
      emitLoading: false,
    );
  }

  Map<String, int> _computeFlagCounts(List<FlagRecord> flags) {
    final counts = <String, int>{};
    for (final flag in flags) {
      counts[flag.postUrl] = (counts[flag.postUrl] ?? 0) + 1;
    }
    return counts;
  }
}
