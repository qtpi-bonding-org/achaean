import 'package:flutter/material.dart';
import 'package:flutter_color_palette/flutter_color_palette.dart';
import '../primitives/app_palette.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Athenian civic theme implementation.
class AppTheme {
  /// Light theme — limestone and terracotta
  static ThemeData get lightTheme => _buildTheme(AppPalette.primary);

  /// Dark theme — temple interior at night
  static ThemeData get darkTheme => _buildTheme(AppPalette.dark);

  static ThemeData _buildTheme(IColorPalette palette) {
    final isDark = palette == AppPalette.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: AppFonts.textTheme.apply(
        bodyColor: palette.textPrimary,
        displayColor: palette.textPrimary,
      ),
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: palette.primaryColor,
        onPrimary: palette.backgroundPrimary,
        secondary: palette.highlightColor,
        onSecondary: palette.textPrimary,
        tertiary: palette.textSecondary,
        onTertiary: palette.backgroundPrimary,
        error: palette.destructiveColor,
        onError: palette.backgroundPrimary,
        surface: palette.backgroundPrimary,
        onSurface: palette.textPrimary,
        surfaceContainerHighest: palette.surfaceColor,
      ),
      scaffoldBackgroundColor: palette.backgroundPrimary,
      dividerColor: palette.textSecondary.withValues(alpha: 0.3),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primaryColor,
          foregroundColor: palette.backgroundPrimary,
          minimumSize: Size.fromHeight(AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
          textStyle: TextStyle(
            fontFamily: AppFonts.bodyFamily,
            fontSize: AppSizes.fontStandard,
            fontWeight: AppFonts.medium,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette.primaryColor,
          foregroundColor: palette.backgroundPrimary,
          minimumSize: Size.fromHeight(AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
          textStyle: TextStyle(
            fontFamily: AppFonts.bodyFamily,
            fontSize: AppSizes.fontStandard,
            fontWeight: AppFonts.medium,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: palette.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          side: BorderSide(
            color: palette.textSecondary.withValues(alpha: 0.2),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.backgroundPrimary,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: AppSizes.appBarHeight,
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.headerFamily,
          fontSize: AppSizes.fontBig,
          fontWeight: AppFonts.heavy,
          color: palette.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: palette.textSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(
            color: palette.primaryColor,
            width: AppSizes.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: palette.destructiveColor),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.space * 2,
          vertical: AppSizes.space * 1.5,
        ),
      ),
      // Disable FAB — actions go in app bar or inline
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        sizeConstraints: BoxConstraints.tightFor(width: 0, height: 0),
      ),
      // Bottom nav uses stone colors
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: palette.backgroundPrimary,
        selectedItemColor: palette.primaryColor,
        unselectedItemColor: palette.textSecondary,
      ),
    );
  }
}

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}
