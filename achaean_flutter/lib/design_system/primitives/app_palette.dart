import 'package:flutter/material.dart';
import 'package:flutter_color_palette/flutter_color_palette.dart';

/// Athenian civic color palette — warm stone, terracotta, and gold.
class AppPalette {
  /// Light mode — limestone and terracotta
  static final IColorPalette primary = AppColorPalette(
    colors: const {
      // Core palette (light mode)
      'color1': Color(0xFFF5F0E8), // Background — limestone
      'color2': Color(0xFF2A2A2A), // Text primary — charcoal inscription
      'color3': Color(0xFFC4602D), // Primary accent — terracotta
      'neutral1': Color(0xFF9B9083), // Secondary text / borders — weathered stone
      'surface': Color(0xFFEDE8DE), // Cards, elevated surfaces — deeper stone

      // Interactable color
      'interactable': Color(0xFFC4602D), // Terracotta

      // Accent highlight
      'highlight': Color(0xFFB8973A), // Muted gold

      // Semantic colors
      'info': Color(0xFFB9D9ED), // Blue
      'success': Color(0xFF5C6B3C), // Olive
      'error': Color(0xFF8B3A2A), // Burnt terracotta
      'warning': Color(0xFFF5E6A3), // Yellow

      // Destructive color
      'destructive': Color(0xFF8B3A2A), // Burnt terracotta

      // Decorative — dark clay for meanders, ornamental borders
      'ornament': Color(0xFF6B4226), // Dark clay brown
    },
    name: 'Athenian Light',
  );

  /// Dark mode — inverted stone (temple interior at night)
  static final IColorPalette dark = AppColorPalette(
    colors: const {
      // Core palette (dark mode)
      'color1': Color(0xFF1E1D1B), // Background — dark slate
      'color2': Color(0xFFE8E2D8), // Text primary — light stone
      'color3': Color(0xFFC4602D), // Primary accent — terracotta (same)
      'neutral1': Color(0xFF7A7166), // Secondary text / borders — muted stone
      'surface': Color(0xFF2A2823), // Cards, elevated surfaces — warm dark

      // Interactable color
      'interactable': Color(0xFFC4602D), // Terracotta (same)

      // Accent highlight
      'highlight': Color(0xFFB8973A), // Muted gold (same)

      // Semantic colors
      'info': Color(0xFF5A8FAD), // Muted blue
      'success': Color(0xFF7A8F5A), // Lighter olive
      'error': Color(0xFFC4602D), // Terracotta
      'warning': Color(0xFFD4C67A), // Muted yellow

      // Destructive color
      'destructive': Color(0xFFC4602D), // Terracotta

      // Decorative — lighter clay for dark mode ornaments
      'ornament': Color(0xFF9B7A5A), // Warm clay
    },
    name: 'Athenian Dark',
  );
}

/// Extension for semantic color access
extension AppColors on IColorPalette {
  // Background & Surface
  Color get backgroundPrimary => getColor('color1')!;
  Color get surfaceColor => getColor('surface')!;

  // Text
  Color get textPrimary => getColor('color2')!;
  Color get textSecondary => getColor('neutral1')!;

  // Accent/Primary action color
  Color get primaryColor => getColor('color3')!;

  // Interactable
  Color get interactableColor => getColor('interactable')!;

  // Highlight (gold)
  Color get highlightColor => getColor('highlight')!;

  // Semantic colors
  Color get infoColor => getColor('info')!;
  Color get successColor => getColor('success')!;
  Color get errorColor => getColor('error')!;
  Color get warningColor => getColor('warning')!;

  // Destructive color
  Color get destructiveColor => getColor('destructive')!;

  // Decorative ornament color (meanders, borders)
  Color get ornamentColor => getColor('ornament')!;
}
