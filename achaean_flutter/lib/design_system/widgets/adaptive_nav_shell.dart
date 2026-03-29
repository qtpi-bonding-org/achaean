import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';

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
class AdaptiveNavShell extends StatelessWidget {
  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;
  final Widget child;

  const AdaptiveNavShell({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTapped,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    if (isLandscape) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              _FlutedRail(
                child: NavigationRail(
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
              ),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: child),
            ],
          ),
        ),
      );
    }

    return Scaffold(
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
    );
  }
}

/// Wraps the NavigationRail with subtle vertical fluting lines
/// evoking Doric column texture.
class _FlutedRail extends StatelessWidget {
  final Widget child;

  const _FlutedRail({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _FlutingPainter(
        color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.08),
        spacing: AppSizes.space,
      ),
      child: child,
    );
  }
}

class _FlutingPainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _FlutingPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    for (var x = spacing; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_FlutingPainter oldDelegate) =>
      color != oldDelegate.color || spacing != oldDelegate.spacing;
}
