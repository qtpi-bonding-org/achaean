import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../cubit/personal_feed_cubit.dart';
import '../cubit/personal_feed_state.dart';
import '../widgets/post_reference_tile.dart';

class PersonalFeedScreen extends StatefulWidget {
  const PersonalFeedScreen({super.key});

  @override
  State<PersonalFeedScreen> createState() => _PersonalFeedScreenState();
}

class _PersonalFeedScreenState extends State<PersonalFeedScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PersonalFeedCubit>().loadFeed();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
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
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => AppNavigation.toCreatePost(context),
          tooltip: 'New post',
        ),
      ],
      body: BlocBuilder<PersonalFeedCubit, PersonalFeedState>(
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
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final ref = state.posts[index];
                return PostReferenceTile(
                  postRef: ref,
                  onTap: () => AppNavigation.toPostDetail(context, ref),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
