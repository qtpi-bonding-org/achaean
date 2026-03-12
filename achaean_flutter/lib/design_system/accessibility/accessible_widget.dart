import 'package:flutter/material.dart';

/// Mixin that enforces accessibility intent declaration on design system widgets.
///
/// Every visual widget must declare whether it is decorative (screen reader
/// skips it) or functional (screen reader announces it). This is enforced
/// at compile time via the required [decorative] parameter.
///
/// Usage:
/// ```dart
/// class MyButton extends StatelessWidget with AccessibleWidget {
///   @override
///   final bool decorative;
///   @override
///   final String? semanticLabel;
///
///   const MyButton({required this.decorative, this.semanticLabel, ...});
///
///   @override
///   Widget build(BuildContext context) {
///     return buildAccessible(
///       child: FilledButton(...),
///     );
///   }
/// }
/// ```
mixin AccessibleWidget on StatelessWidget {
  /// If true, the widget is decorative and will be excluded from the
  /// semantics tree (screen reader will skip it).
  /// If false, the widget is functional and will be included.
  bool get decorative;

  /// Optional explicit semantic label. If null and [decorative] is false,
  /// Flutter will auto-extract labels from child [Text] widgets.
  String? get semanticLabel;

  /// Wraps [child] with the appropriate semantics widget based on
  /// [decorative] and [semanticLabel].
  Widget buildAccessible({required Widget child}) {
    if (decorative) {
      return ExcludeSemantics(child: child);
    }
    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, child: child);
    }
    // Functional with no explicit label — Flutter auto-extracts from Text children
    return child;
  }
}
