import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../l10n/app_localizations.dart';
import '../../post_creation/cubit/own_posts_cubit.dart';
import '../../post_creation/cubit/own_posts_state.dart';
import '../../post_creation/widgets/post_card.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<ProfileCubit>()..loadOwnProfile()),
        BlocProvider(create: (_) => GetIt.instance<OwnPostsCubit>()..loadPosts()),
      ],
      child: const _ProfileScreenBody(),
    );
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: l10n.profileTitle,
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => AppNavigation.toEditProfile(context),
          tooltip: l10n.editProfile,
        ),
      ],
      body: CustomScrollView(
        slivers: [
          // Profile header
          SliverToBoxAdapter(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final profile = state.profile;
                return Padding(
                  padding: EdgeInsets.all(AppSizes.space * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.displayName ?? l10n.anonymous,
                        style: theme.textTheme.headlineSmall,
                      ),
                      if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                        SizedBox(height: AppSizes.space),
                        Text(
                          profile.bio!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: StoneDivider()),
          // Posts header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.space * 2,
                vertical: AppSizes.space,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.ownPostsTitle,
                      style: theme.textTheme.titleMedium),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => AppNavigation.toCreatePost(context),
                    tooltip: 'New post',
                  ),
                ],
              ),
            ),
          ),
          // Posts list
          BlocBuilder<OwnPostsCubit, OwnPostsState>(
            builder: (context, state) {
              if (state.posts.isEmpty && state.isSuccess) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.space * 2),
                      child: Text(l10n.ownPostsEmpty),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PostCard(post: state.posts[index]),
                  childCount: state.posts.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
