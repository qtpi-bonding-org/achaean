import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/own_posts_cubit.dart';
import '../cubit/own_posts_state.dart';
import '../widgets/post_card.dart';

class OwnPostsScreen extends StatelessWidget {
  const OwnPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<OwnPostsCubit>()..loadPosts(),
      child: const _OwnPostsScreenBody(),
    );
  }
}

class _OwnPostsScreenBody extends StatelessWidget {
  const _OwnPostsScreenBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.ownPostsTitle)),
      body: SimpleUiFlowListener<OwnPostsCubit, OwnPostsState>(
        child: BlocBuilder<OwnPostsCubit, OwnPostsState>(
          builder: (context, state) {
            if (state.posts.isEmpty && state.isSuccess) {
              return Center(child: Text(l10n.ownPostsEmpty));
            }

            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) =>
                  PostCard(post: state.posts[index]),
            );
          },
        ),
      ),
    );
  }
}
