import 'package:flutter/material.dart';

import '../accessibility/accessible_widget.dart';

/// A navigation destination for [AdaptiveNavShell].
class NavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const NavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

/// Adaptive navigation shell that switches between bottom nav (portrait)
/// and side rail (landscape) based on device orientation.
///
/// Wraps content in [SafeArea] to handle notches, status bars,
/// and home indicators.
///
/// Usage with GoRouter ShellRoute:
/// ```dart
/// ShellRoute(
///   builder: (context, state, child) => AdaptiveNavShell(
///     items: [
///       NavItem(icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
///       NavItem(icon: Icons.settings_outlined, selectedIcon: Icons.settings, label: 'Settings'),
///     ],
///     currentIndex: _indexFromLocation(state.matchedLocation),
///     onItemTapped: (index) => _navigateToIndex(context, index),
///     child: child,
///   ),
/// )
/// ```
class AdaptiveNavShell extends StatelessWidget with AccessibleWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;
  final Widget child;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const AdaptiveNavShell({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTapped,
    required this.child,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    if (isLandscape) {
      return buildAccessible(child: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: currentIndex,
                onDestinationSelected: onItemTapped,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  for (final item in items)
                    NavigationRailDestination(
                      icon: Icon(item.icon),
                      selectedIcon:
                          item.selectedIcon != null ? Icon(item.selectedIcon) : null,
                      label: Text(item.label),
                    ),
                ],
              ),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: child),
            ],
          ),
        ),
      ));
    }

    return buildAccessible(child: Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onItemTapped,
        destinations: [
          for (final item in items)
            NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon:
                  item.selectedIcon != null ? Icon(item.selectedIcon) : null,
              label: item.label,
            ),
        ],
      ),
    ));
  }
}
