import 'package:flutter/material.dart';
import 'app_sizes.dart';

/// Athenian civic typography system.
///
/// Headers: Cinzel — inscriptional, monumental, carved-in-stone presence.
/// Body: League Spartan — geometric, sturdy, built-to-last foundation.
class AppFonts {
  /// Header font family — inscriptional serif
  static const String headerFamily = 'Cinzel';
  static const List<String> headerFontFallbacks = ['Cinzel'];

  /// Body font family — geometric sans-serif
  static const String bodyFamily = 'LeagueSpartan';
  static const List<String> bodyFontFallbacks = ['LeagueSpartan'];

  // Weight Classes
  static const FontWeight heavy = FontWeight.w700; // The Pediment
  static const FontWeight medium = FontWeight.w400; // The Column
  static const FontWeight light = FontWeight.w300; // The Inscription

  /// Text theme
  static TextTheme get textTheme => TextTheme(
        // Display — monumental headers (Cinzel)
        displayLarge: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontMassive,
          fontWeight: heavy,
        ),
        displayMedium: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontMassive,
          fontWeight: heavy,
        ),
        displaySmall: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontLarge,
          fontWeight: heavy,
        ),

        // Headlines (Cinzel)
        headlineLarge: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontLarge,
          fontWeight: heavy,
        ),
        headlineMedium: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontBig,
          fontWeight: heavy,
        ),
        headlineSmall: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontStandard,
          fontWeight: heavy,
        ),

        // Titles (Cinzel)
        titleLarge: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontLarge,
          fontWeight: heavy,
        ),
        titleMedium: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontStandard,
          fontWeight: heavy,
        ),
        titleSmall: TextStyle(
          fontFamily: headerFamily,
          fontFamilyFallback: headerFontFallbacks,
          fontSize: AppSizes.fontSmall,
          fontWeight: heavy,
        ),

        // Body (League Spartan)
        bodyLarge: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontStandard,
          fontWeight: medium,
        ),
        bodyMedium: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontSmall,
          fontWeight: medium,
        ),
        bodySmall: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontMini,
          fontWeight: medium,
        ),

        // Labels (League Spartan)
        labelLarge: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontStandard,
          fontWeight: medium,
        ),
        labelMedium: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontSmall,
          fontWeight: medium,
        ),
        labelSmall: TextStyle(
          fontFamily: bodyFamily,
          fontFamilyFallback: bodyFontFallbacks,
          fontSize: AppSizes.fontMini,
          fontWeight: light,
        ),
      );

  AppFonts._();
}
