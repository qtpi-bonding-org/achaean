# Athenian Civic Widget Library Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build 9 standardized widgets that enforce the Athenian civic design rules, so all screens compose from these instead of ad-hoc Material styling.

**Architecture:** Pure presentational widgets in `design_system/widgets/`. No business logic, no DI, no cubits. Each widget uses `AppPalette`, `AppFonts`, and `AppSizes` for all styling. Screens compose these widgets exclusively.

**Tech Stack:** Flutter, Material 3 (themed/overridden), AppPalette/AppFonts/AppSizes design tokens

**Steering docs:** Read `achaean_flutter/.agent/steering/` for project patterns (cubits, DI, error handling). These widgets are leaf-level — they don't use cubits or services, but screens that compose them will.

---

## Task 1: StoneDivider

The workhorse separator. A horizontal line in weathered stone color.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/stone_divider.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_palette.dart';
import '../primitives/app_sizes.dart';
import '../theme/theme_service.dart';
import 'package:get_it/get_it.dart';

/// Horizontal stone divider — the primary content separator.
///
/// Use instead of Material Divider. Renders as a single line in
/// weathered stone color with consistent vertical spacing.
class StoneDivider extends StatelessWidget {
  /// Vertical padding above and below the line.
  final double? verticalPadding;

  /// Horizontal indent from edges.
  final double? indent;

  const StoneDivider({
    super.key,
    this.verticalPadding,
    this.indent,
  });

  @override
  Widget build(BuildContext context) {
    final palette = GetIt.instance<ThemeService>().currentPalette;
    final vPad = verticalPadding ?? AppSizes.space;
    final hIndent = indent ?? 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: vPad),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: hIndent),
        height: AppSizes.borderWidth,
        color: palette.textSecondary.withValues(alpha: 0.3),
      ),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/stone_divider.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/stone_divider.dart
git commit -m "feat: add StoneDivider widget"
```

---

## Task 2: EntablatureHeader

Section header: Cinzel title + optional subtitle + stone divider below. Like the entablature on a Greek temple — the decorated band that marks a structural division.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/entablature_header.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';
import 'stone_divider.dart';

/// Section header with Cinzel title, optional subtitle, and stone divider below.
///
/// Use to mark major content sections. The title renders in Cinzel (via
/// headlineMedium), the subtitle in League Spartan (via bodyMedium).
class EntablatureHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const EntablatureHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headlineMedium,
        ),
        if (subtitle != null) ...[
          SizedBox(height: AppSizes.space * 0.5),
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.tertiary,
            ),
          ),
        ],
        const StoneDivider(),
      ],
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/entablature_header.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/entablature_header.dart
git commit -m "feat: add EntablatureHeader widget"
```

---

## Task 3: TerracottaButton

The one primary action button. Filled terracotta, limestone text, square corners. No pills, no outlines.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/terracotta_button.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Primary action button — filled terracotta with limestone text.
///
/// Use for the single primary action on a screen. For secondary actions,
/// use [FlatTextButton] instead. Never use FABs or outline buttons.
class TerracottaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const TerracottaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: AppSizes.buttonHeight,
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
          textStyle: TextStyle(
            fontFamily: AppFonts.bodyFamily,
            fontSize: AppSizes.fontStandard,
            fontWeight: AppFonts.medium,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: AppSizes.iconMedium,
                width: AppSizes.iconMedium,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.onPrimary,
                ),
              )
            : Text(label),
      ),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/terracotta_button.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/terracotta_button.dart
git commit -m "feat: add TerracottaButton widget"
```

---

## Task 4: FlatTextButton

Secondary action button. Just text, no chrome. Terracotta or charcoal text depending on emphasis.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/flat_text_button.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';

/// Secondary action button — text only, no background or border.
///
/// Use for secondary or tertiary actions. Set [isPrimary] to true
/// for terracotta text (more emphasis), false for charcoal text (less).
class FlatTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const FlatTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor:
            isPrimary ? colorScheme.primary : colorScheme.onSurface,
        textStyle: TextStyle(
          fontFamily: AppFonts.bodyFamily,
          fontSize: AppSizes.fontStandard,
          fontWeight: AppFonts.medium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
        ),
      ),
      child: Text(label),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/flat_text_button.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/flat_text_button.dart
git commit -m "feat: add FlatTextButton widget"
```

---

## Task 5: InscriptionTile

The universal list row. Used for posts, poleis, trust declarations, members — anything that appears in a list. Title + optional subtitle + optional trailing widget, separated by stone dividers.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/inscription_tile.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';
import 'stone_divider.dart';

/// Universal list row — title, optional subtitle, optional trailing element.
///
/// Separated by [StoneDivider] below. Use for posts, poleis, members,
/// trust declarations — any content that appears in a vertical list.
/// Do not wrap in cards.
class InscriptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool showDivider;

  const InscriptionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.space * 2,
              vertical: AppSizes.space * 1.5,
            ),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: AppSizes.space * 1.5),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.titleSmall,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: AppSizes.space * 0.5),
                        Text(
                          subtitle!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: AppSizes.space),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
        if (showDivider)
          StoneDivider(
            verticalPadding: 0,
            indent: AppSizes.space * 2,
          ),
      ],
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/inscription_tile.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/inscription_tile.dart
git commit -m "feat: add InscriptionTile widget"
```

---

## Task 6: ReliefCard

For when you truly need a card — post previews, grouped info. Subtle stone border, no shadow, slight surface color shift. Used sparingly.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/relief_card.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Subtle card with stone border — use sparingly.
///
/// For when content needs grouping (post previews, profile headers).
/// No shadow, no elevation. Slight surface color shift with a thin
/// stone-colored border. Prefer [InscriptionTile] + [StoneDivider]
/// for lists.
class ReliefCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const ReliefCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.all(AppSizes.space * 2),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: context.colorScheme.tertiary.withValues(alpha: 0.2),
          width: AppSizes.borderWidth,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/relief_card.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/relief_card.dart
git commit -m "feat: add ReliefCard widget"
```

---

## Task 7: ChiseledTextField

The one text input. Stone-colored border, terracotta focus border, square corners.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/chiseled_text_field.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_fonts.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Text input with stone border and terracotta focus highlight.
///
/// Wraps [TextField] with consistent Athenian civic styling.
/// Square corners, no rounded pills.
class ChiseledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final int maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const ChiseledTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.tertiary,
        ),
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.tertiary.withValues(alpha: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.tertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: AppSizes.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.space * 2,
          vertical: AppSizes.space * 1.5,
        ),
      ),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/chiseled_text_field.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/chiseled_text_field.dart
git commit -m "feat: add ChiseledTextField widget"
```

---

## Task 8: MuseumFrame

Stone border wrapper for user-authored HTML content. Gives rich posts a "displayed artifact" feel.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/museum_frame.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Stone border frame for displaying user-authored rich content.
///
/// Wraps HTML/rich content in a museum-style frame — the building
/// is consistent stone, the art inside is the author's. Use for
/// [RichReadablePost] content rendered in a webview.
class MuseumFrame extends StatelessWidget {
  final Widget child;

  const MuseumFrame({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.tertiary.withValues(alpha: 0.4),
          width: AppSizes.borderWidthThick,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
        child: child,
      ),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/museum_frame.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/museum_frame.dart
git commit -m "feat: add MuseumFrame widget"
```

---

## Task 9: AchaeanScaffold

The screen wrapper. Stone background, Cinzel app bar title, handles safe area. Every screen uses this instead of raw `Scaffold`.

**Files:**
- Create: `achaean_flutter/lib/design_system/widgets/achaean_scaffold.dart`

**Step 1: Create the widget**

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// App scaffold — stone background with Cinzel-titled app bar.
///
/// Every screen should use this instead of raw [Scaffold].
/// Provides consistent app bar styling, background color,
/// and optional actions.
class AchaeanScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;

  const AchaeanScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              automaticallyImplyLeading: showBackButton,
              leading: showBackButton && onBack != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: onBack,
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: SafeArea(
        top: title == null,
        child: body,
      ),
    );
  }
}
```

**Step 2: Verify it compiles**

Run: `cd achaean_flutter && flutter analyze lib/design_system/widgets/achaean_scaffold.dart`
Expected: No errors.

**Step 3: Commit**

```bash
git add achaean_flutter/lib/design_system/widgets/achaean_scaffold.dart
git commit -m "feat: add AchaeanScaffold widget"
```

---

## Task 10: Full compilation check + update theme defaults

After all widgets are created, verify everything compiles together and update `app_theme.dart` to override Material defaults that conflict with design rules (disable FAB theme, force square corners globally).

**Files:**
- Modify: `achaean_flutter/lib/design_system/theme/app_theme.dart`

**Step 1: Update theme to disable Material defaults that conflict**

In `app_theme.dart`, add these overrides inside `_buildTheme()` after the existing `inputDecorationTheme`:

```dart
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
```

**Step 2: Analyze the entire design_system directory**

Run: `cd achaean_flutter && flutter analyze lib/design_system/`
Expected: No errors.

**Step 3: Analyze the full app**

Run: `cd achaean_flutter && flutter analyze`
Expected: No errors (only the pre-existing deprecation warning).

**Step 4: Commit**

```bash
git add achaean_flutter/lib/design_system/
git commit -m "feat: complete Athenian civic widget library"
```

---

## Implementation Order

```
Tasks 1-9 are sequential (each builds on StoneDivider).
Task 1 (StoneDivider)        — no deps
Task 2 (EntablatureHeader)   — depends on Task 1
Task 3 (TerracottaButton)    — no deps
Task 4 (FlatTextButton)      — no deps
Task 5 (InscriptionTile)     — depends on Task 1
Task 6 (ReliefCard)          — no deps
Task 7 (ChiseledTextField)   — no deps
Task 8 (MuseumFrame)         — no deps
Task 9 (AchaeanScaffold)     — no deps
Task 10 (theme + verify)     — depends on all above
```

Tasks 3, 4, 6, 7, 8, 9 can run in parallel after Task 1. Task 2 and 5 need Task 1. Task 10 is last.

---

## Critical Files to Reference

| File | What to reuse |
|------|---------------|
| `achaean_flutter/lib/design_system/primitives/app_palette.dart` | `AppPalette.primary` / `.dark`, color accessors |
| `achaean_flutter/lib/design_system/primitives/app_fonts.dart` | `AppFonts.headerFamily`, `.bodyFamily`, weight constants |
| `achaean_flutter/lib/design_system/primitives/app_sizes.dart` | `AppSizes.space`, `.radiusTiny`, `.borderWidth`, etc. |
| `achaean_flutter/lib/design_system/theme/app_theme.dart` | `AppThemeExtension` — `context.textTheme`, `context.colorScheme` |
| `achaean_flutter/lib/design_system/theme/theme_service.dart` | `ThemeService.currentPalette` for palette access outside widget tree |
| `achaean_flutter/lib/design_system/widgets/ui_flow_listener.dart` | Existing widget — keep as-is, it handles toasts via theme colors |
| `achaean_flutter/.agent/steering/development_standards.md` | Project patterns and rules |
