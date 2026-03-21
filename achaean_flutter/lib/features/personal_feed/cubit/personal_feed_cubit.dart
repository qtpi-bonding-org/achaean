import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../../agora/services/i_agora_service.dart';
import '../services/post_content_cache.dart';
import 'personal_feed_state.dart';

class PersonalFeedCubit extends AppCubit<PersonalFeedState> {
  final IAgoraService _agoraService;
  final PostContentCache _contentCache;

  static const _pageSize = 50;

  PersonalFeedCubit(this._agoraService, this._contentCache)
      : super(const PersonalFeedState());

  /// Load the personal feed (initial load).
  Future<void> loadFeed() async {
    await tryOperation(
      () async {
        final posts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: 0,
        );

        // Eagerly prefetch content in background
        _contentCache.prefetch(posts);

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
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
    if (!state.hasMore) return;

    await tryOperation(
      () async {
        final morePosts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: state.offset,
        );

        // Eagerly prefetch content for new posts
        _contentCache.prefetch(morePosts);

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

  /// Refresh the feed (pull-to-refresh).
  Future<void> refresh() async {
    await tryOperation(
      () async {
        final posts = await _agoraService.getPersonalFeed(
          limit: _pageSize,
          offset: 0,
        );

        _contentCache.prefetch(posts);

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          hasMore: posts.length >= _pageSize,
          offset: posts.length,
          error: null,
        );
      },
      emitLoading: false,
    );
  }
}
