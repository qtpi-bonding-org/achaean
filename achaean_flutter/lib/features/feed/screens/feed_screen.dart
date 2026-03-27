import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../personal_feed/cubit/personal_feed_cubit.dart';
import '../../personal_feed/cubit/personal_feed_state.dart';
import '../../personal_feed/widgets/post_reference_tile.dart';
import '../widgets/agora_content.dart';

/// Top-level feed screen with Personal and Agora tabs.
///
/// Personal tab mirrors the content of the old [PersonalFeedScreen] with
/// scroll-based pagination and pull-to-refresh.
/// Agora tab shows [AgoraContent] with a polis dropdown and community feed.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<PersonalFeedCubit>().loadFeed();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PersonalFeedCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AchaeanScaffold(
      title: 'Feed',
      showBackButton: false,
      actions: [
        if (!AppRouter.isGuest)
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => AppNavigation.toCreatePost(context),
            tooltip: 'New post',
          ),
      ],
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Personal'),
              Tab(text: 'Agora'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _PersonalFeedContent(scrollController: _scrollController),
                const AgoraContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalFeedContent extends StatelessWidget {
  final ScrollController scrollController;

  const _PersonalFeedContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalFeedCubit, PersonalFeedState>(
      builder: (context, state) {
        if (state.isLoading && state.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isFailure && state.posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Failed to load feed',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSizes.space),
                TextButton(
                  onPressed: () =>
                      context.read<PersonalFeedCubit>().loadFeed(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.posts.isEmpty && state.isSuccess) {
          return Center(
            child: Text(
              'No posts yet. Trust someone to see their posts here.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<PersonalFeedCubit>().refresh(),
          child: ListView.builder(
            controller: scrollController,
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final ref = state.posts[index];
              return PostReferenceTile(
                postRef: ref,
                onTap: () => AppNavigation.toPostDetail(context, ref),
                onAuthorTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: ref.authorPubkey,
                  repoUrl: ref.authorRepoUrl,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
