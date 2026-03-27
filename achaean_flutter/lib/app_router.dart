import 'package:achaean_client/achaean_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'design_system/widgets/adaptive_nav_shell.dart';
import 'features/account_creation/screens/account_creation_screen.dart';
import 'features/agora/cubit/agora_cubit.dart';
import 'features/connections/screens/connections_screen.dart';
import 'features/connections/screens/create_polis_screen.dart';
import 'features/connections/screens/polis_detail_screen.dart';
import 'features/feed/screens/feed_screen.dart';
import 'features/observe/cubit/observe_cubit.dart';
import 'features/people/screens/user_detail_screen.dart';
import 'features/personal_feed/cubit/personal_feed_cubit.dart';
import 'features/personal_feed/screens/post_detail_screen.dart';
import 'features/personal_feed/services/post_content_cache.dart';
import 'features/polis/cubit/polis_cubit.dart';
import 'features/post_creation/cubit/own_posts_cubit.dart';
import 'features/post_creation/screens/post_creation_screen.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/trust/cubit/trust_cubit.dart';

/// App routing configuration.
class AppRouter {
  AppRouter._();

  /// Whether the user has an account. Set during bootstrap.
  static bool _hasAccount = false;

  /// Whether the app is running in guest mode.
  static bool _isGuest = false;

  /// Call during bootstrap after checking IKeyService.hasKeypair().
  static void setHasAccount(bool value) => _hasAccount = value;

  /// Enable or disable guest mode.
  static void setIsGuest(bool value) => _isGuest = value;

  /// Whether the app is currently in guest mode.
  static bool get isGuest => _isGuest;

  static GoRouter get router => _router;

  /// Nav items displayed in the adaptive shell.
  /// Add/remove/reorder items here — the shell adapts automatically.
  static const _navItems = [
    NavItem(icon: Icons.article_outlined, selectedIcon: Icons.article, label: 'Feed'),
    NavItem(icon: Icons.person_outlined, selectedIcon: Icons.person, label: 'Profile'),
    NavItem(icon: Icons.group_outlined, selectedIcon: Icons.group, label: 'Connections'),
    NavItem(icon: Icons.settings_outlined, selectedIcon: Icons.settings, label: 'Settings'),
  ];

  /// Ordered routes corresponding to [_navItems] by index.
  static const _navRoutes = [
    AppRoutes.home,
    AppRoutes.profile,
    AppRoutes.connections,
    AppRoutes.settings,
  ];

  static int _indexFromLocation(String location) {
    final index = _navRoutes.indexOf(location);
    return index >= 0 ? index : 0;
  }

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final goingToCreateAccount =
          state.matchedLocation == AppRoutes.createAccount;

      if (!_hasAccount && !_isGuest && !goingToCreateAccount) {
        return AppRoutes.createAccount;
      }
      if ((_hasAccount || _isGuest) && goingToCreateAccount) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => AdaptiveNavShell(
          items: _navItems,
          currentIndex: _indexFromLocation(state.matchedLocation),
          onItemTapped: (index) => context.go(_navRoutes[index]),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: RouteNames.home,
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => GetIt.instance<PersonalFeedCubit>()),
                BlocProvider(create: (_) => GetIt.instance<PolisCubit>()),
                BlocProvider(create: (_) => GetIt.instance<AgoraCubit>()),
              ],
              child: const FeedScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: RouteNames.profile,
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => GetIt.instance<ProfileCubit>()),
                BlocProvider(create: (_) => GetIt.instance<OwnPostsCubit>()),
              ],
              child: const ProfileScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.connections,
            name: RouteNames.connections,
            builder: (context, state) => const ConnectionsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: RouteNames.settings,
            builder: (context, state) =>
                const Center(child: Text('Settings Page')),
          ),
        ],
      ),
      // Pushed routes (not in nav shell)
      GoRoute(
        path: AppRoutes.createAccount,
        name: RouteNames.createAccount,
        builder: (context, state) => const AccountCreationScreen(),
      ),
      GoRoute(
        path: AppRoutes.createPost,
        name: RouteNames.createPost,
        builder: (context, state) => const PostCreationScreen(),
      ),
      GoRoute(
        path: AppRoutes.postDetail,
        name: RouteNames.postDetail,
        builder: (context, state) {
          final ref = state.extra! as PostReference;
          return PostDetailScreen(
            postRef: ref,
            contentCache: GetIt.instance<PostContentCache>(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: RouteNames.editProfile,
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.instance<ProfileCubit>()..loadOwnProfile(),
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.userDetail,
        name: RouteNames.userDetail,
        builder: (context, state) {
          final args = state.extra! as UserDetailArgs;
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => GetIt.instance<TrustCubit>()),
              BlocProvider(create: (_) => GetIt.instance<ObserveCubit>()),
            ],
            child: UserDetailScreen(args: args),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.polisDetail,
        name: RouteNames.polisDetail,
        builder: (context, state) {
          final args = state.extra! as PolisDetailArgs;
          return BlocProvider(
            create: (_) => GetIt.instance<PolisCubit>(),
            child: PolisDetailScreen(args: args),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createPolis,
        name: RouteNames.createPolis,
        builder: (context, state) => BlocProvider(
          create: (_) => GetIt.instance<PolisCubit>(),
          child: const CreatePolisScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
}

class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String profile = '/profile';
  static const String connections = '/connections';
  static const String settings = '/settings';
  static const String createAccount = '/create-account';
  static const String createPost = '/create-post';
  static const String postDetail = '/post-detail';
  static const String editProfile = '/edit-profile';
  static const String userDetail = '/user-detail';
  static const String polisDetail = '/polis-detail';
  static const String createPolis = '/create-polis';
}

class RouteNames {
  RouteNames._();
  static const String home = 'home';
  static const String profile = 'profile';
  static const String connections = 'connections';
  static const String settings = 'settings';
  static const String createAccount = 'createAccount';
  static const String createPost = 'createPost';
  static const String postDetail = 'postDetail';
  static const String editProfile = 'editProfile';
  static const String userDetail = 'userDetail';
  static const String polisDetail = 'polisDetail';
  static const String createPolis = 'createPolis';
}

class AppNavigation {
  AppNavigation._();

  static void toFeed(BuildContext context) => context.goNamed(RouteNames.home);
  static void toProfile(BuildContext context) => context.goNamed(RouteNames.profile);
  static void toConnections(BuildContext context) => context.goNamed(RouteNames.connections);
  static void toSettings(BuildContext context) => context.goNamed(RouteNames.settings);
  static void toCreateAccount(BuildContext context) => context.pushNamed(RouteNames.createAccount);
  static void toCreatePost(BuildContext context) => context.pushNamed(RouteNames.createPost);
  static void toPostDetail(BuildContext context, PostReference ref) =>
      context.pushNamed(RouteNames.postDetail, extra: ref);
  static void toEditProfile(BuildContext context) => context.pushNamed(RouteNames.editProfile);
  static void toUserDetail(BuildContext context, {required String pubkey, required String repoUrl}) =>
      context.pushNamed(RouteNames.userDetail, extra: UserDetailArgs(pubkey: pubkey, repoUrl: repoUrl));
  static void toPolisDetail(BuildContext context, {required String repoUrl, required String name}) =>
      context.pushNamed(RouteNames.polisDetail, extra: PolisDetailArgs(repoUrl: repoUrl, name: name));
  static void toCreatePolis(BuildContext context) => context.pushNamed(RouteNames.createPolis);

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      toFeed(context);
    }
  }
}
