import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/account_creation/screens/account_creation_screen.dart';
import 'features/post_creation/screens/own_posts_screen.dart';
import 'features/post_creation/screens/post_creation_screen.dart';

/// App routing configuration.
class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: RouteNames.home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Page')),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: RouteNames.settings,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings Page')),
        ),
      ),
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
        path: AppRoutes.myPosts,
        name: RouteNames.myPosts,
        builder: (context, state) => const OwnPostsScreen(),
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
      context.pushNamed(RouteNames.settings);
  static void toCreateAccount(BuildContext context) =>
      context.pushNamed(RouteNames.createAccount);
  static void toCreatePost(BuildContext context) =>
      context.pushNamed(RouteNames.createPost);
  static void toMyPosts(BuildContext context) =>
      context.pushNamed(RouteNames.myPosts);

  static void back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      toHome(context);
    }
  }
}
