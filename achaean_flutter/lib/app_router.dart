import 'package:achaean_client/achaean_client.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'core/services/i_key_service.dart';
import 'design_system/widgets/adaptive_nav_shell.dart';
import 'features/account_creation/screens/account_creation_screen.dart';
import 'features/connections/screens/connections_screen.dart';
import 'features/connections/screens/create_polis_screen.dart';
import 'features/connections/screens/polis_detail_screen.dart';
import 'features/feed/screens/feed_screen.dart';
import 'features/people/screens/user_detail_screen.dart';
import 'features/personal_feed/screens/post_detail_screen.dart';
import 'features/personal_feed/services/post_content_cache.dart';
import 'features/post_creation/screens/post_creation_screen.dart';
import 'features/profile/screens/edit_profile_screen.dart';
import 'features/profile/screens/profile_screen.dart';

/// App routing configuration.
class AppRouter {
  AppRouter._();

  /// Whether the user has an account. Set by [initialize].
  static bool _hasAccount = false;

  /// Whether the app is running in guest mode.
  static bool _isGuest = false;

  /// Lazily created router — available after [initialize] completes.
  static late final GoRouter _router;

  /// Checks auth status via [IKeyService] and creates the [GoRouter].
  /// Must be called in bootstrap before [runApp].
  static Future<void> initialize() async {
    _hasAccount = await GetIt.instance<IKeyService>().hasKeypair();
    _router = _buildRouter();
  }

  /// Mark that an account was created (e.g. after OAuth flow).
  static void setHasAccount(bool value) => _hasAccount = value;

  /// Enable or disable guest mode.
  static void setIsGuest(bool value) => _isGuest = value;

  /// Whether the app is currently in guest mode.
  static bool get isGuest => _isGuest;

  /// The configured [GoRouter]. Access after [initialize] has completed.
  static GoRouter get router => _router;

  // ---------------------------------------------------------------------------
  // Nav shell configuration
  // ---------------------------------------------------------------------------

  /// Nav items displayed in the adaptive shell.
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

  // ---------------------------------------------------------------------------
  // Guard redirect
  // ---------------------------------------------------------------------------

  static String? _guardRedirect(BuildContext context, GoRouterState state) {
    final goingToCreateAccount = state.matchedLocation == AppRoutes.createAccount;

    if (!_hasAccount && !_isGuest && !goingToCreateAccount) {
      return AppRoutes.createAccount;
    }
    if ((_hasAccount || _isGuest) && goingToCreateAccount) {
      return AppRoutes.home;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Router factory
  // ---------------------------------------------------------------------------

  static GoRouter _buildRouter() => GoRouter(
        initialLocation: AppRoutes.home,
        redirect: _guardRedirect,
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
                builder: (_, _) => const FeedScreen(),
              ),
              GoRoute(
                path: AppRoutes.profile,
                name: RouteNames.profile,
                builder: (_, _) => const ProfileScreen(),
              ),
              GoRoute(
                path: AppRoutes.connections,
                name: RouteNames.connections,
                builder: (_, _) => const ConnectionsScreen(),
              ),
              GoRoute(
                path: AppRoutes.settings,
                name: RouteNames.settings,
                builder: (_, _) => const Center(child: Text('Settings Page')),
              ),
            ],
          ),
          // Pushed routes (not in nav shell)
          GoRoute(
            path: AppRoutes.createAccount,
            name: RouteNames.createAccount,
            builder: (_, _) => const AccountCreationScreen(),
          ),
          GoRoute(
            path: AppRoutes.createPost,
            name: RouteNames.createPost,
            builder: (_, _) => const PostCreationScreen(),
          ),
          GoRoute(
            path: AppRoutes.postDetail,
            name: RouteNames.postDetail,
            builder: (_, state) {
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
            builder: (_, _) => const EditProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.userDetail,
            name: RouteNames.userDetail,
            builder: (_, state) {
              final args = state.extra! as UserDetailArgs;
              return UserDetailScreen(args: args);
            },
          ),
          GoRoute(
            path: AppRoutes.polisDetail,
            name: RouteNames.polisDetail,
            builder: (_, state) {
              final args = state.extra! as PolisDetailArgs;
              return PolisDetailScreen(args: args);
            },
          ),
          GoRoute(
            path: AppRoutes.createPolis,
            name: RouteNames.createPolis,
            builder: (_, _) => const CreatePolisScreen(),
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
