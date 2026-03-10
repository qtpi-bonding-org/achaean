import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'design_system/widgets/adaptive_nav_shell.dart';
import 'features/account_creation/screens/account_creation_screen.dart';
import 'features/post_creation/screens/own_posts_screen.dart';
import 'features/post_creation/screens/post_creation_screen.dart';

/// App routing configuration.
class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  /// Nav items displayed in the adaptive shell.
  /// Add/remove/reorder items here — the shell adapts automatically.
  static const _navItems = [
    NavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    NavItem(
      icon: Icons.article_outlined,
      selectedIcon: Icons.article,
      label: 'Posts',
    ),
    NavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  /// Ordered routes corresponding to [_navItems] by index.
  static const _navRoutes = [
    AppRoutes.home,
    AppRoutes.myPosts,
    AppRoutes.settings,
  ];

  static int _indexFromLocation(String location) {
    final index = _navRoutes.indexOf(location);
    return index >= 0 ? index : 0;
  }

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
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
            builder: (context, state) =>
                const Center(child: Text('Home Page')),
          ),
          GoRoute(
            path: AppRoutes.myPosts,
            name: RouteNames.myPosts,
            builder: (context, state) => const OwnPostsScreen(),
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
  static const String settings = '/settings';
  static const String createAccount = '/create-account';
  static const String createPost = '/create-post';
  static const String myPosts = '/my-posts';
}

class RouteNames {
  RouteNames._();
  static const String home = 'home';
  static const String settings = 'settings';
  static const String createAccount = 'createAccount';
  static const String createPost = 'createPost';
  static const String myPosts = 'myPosts';
}

class AppNavigation {
  AppNavigation._();

  static void toHome(BuildContext context) => context.goNamed(RouteNames.home);
  static void toSettings(BuildContext context) =>
      context.goNamed(RouteNames.settings);
  static void toMyPosts(BuildContext context) =>
      context.goNamed(RouteNames.myPosts);
  static void toCreateAccount(BuildContext context) =>
      context.pushNamed(RouteNames.createAccount);
  static void toCreatePost(BuildContext context) =>
      context.pushNamed(RouteNames.createPost);

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      toHome(context);
    }
  }
}
