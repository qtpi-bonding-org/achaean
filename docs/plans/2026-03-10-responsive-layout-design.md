# Flutter Responsive Layout Package Design

## Identity

A declarative layout system where you describe content relationships (row, col, grid) and the package handles responsive arrangement across all screen sizes. No breakpoints, no manual `LayoutBuilder`, no screen-size checks.

**Package name:** `flutter_responsive_layout`

**What it is:** Three layout group types that adapt to available space using Flutter's constraint system.

**What it is NOT:** A spacing/scaling system (that's UiScaler/AppSizes), a navigation adapter, or a design system.

**Dependencies:** Flutter only. No external packages.

## How It Fits With UiScaler

Two packages, complementary concerns:

- **UiScaler** — scales *values* (padding, fonts, radii) proportionally with screen width
- **flutter_responsive_layout** — changes *arrangement* (row vs stacked, grid columns) based on available parent space

They connect through one value:

```
UiScaler (scales values)
    ↓ produces
AppSizes.space (base unit)
    ↓ feeds into
ResponsiveLayoutConfig(baseSpacing: AppSizes.space)
    ↓ inherited by
LayoutGroup widgets (use baseSpacing for default gaps, all numeric params are multiples)
```

## One Unit System

All numeric parameters in the package are multiples of `baseSpacing`. No mixing pixels and spacing units.

- `fallbackSpacing: 2` means `2 × baseSpacing`
- `minChildWidth: 40` means `40 × baseSpacing`
- `minItemWidth: 35` means `35 × baseSpacing`
- `HSpace(3)` means `3 × baseSpacing`

If `baseSpacing` is 8dp, then `minChildWidth: 40` = 320dp. If you change `baseSpacing`, adjust the multiplier. One system, no unit confusion.

## API

### Setup (once, app level)

```dart
ResponsiveLayoutConfig(
  baseSpacing: AppSizes.space,
  child: MaterialApp(...),
)
```

`InheritedWidget` that provides `baseSpacing` to all descendant layout groups. If absent, defaults to `8.0`.

### LayoutGroup.col

Always vertical. No adaptation.

```dart
LayoutGroup.col(
  [widget1, widget2, widget3],
  fallbackSpacing: 2,  // nullable, defaults to 1 (1× baseSpacing)
)
```

Children get full available width. Use for explicit vertical stacking and as the top-level container.

### LayoutGroup.row

Side-by-side when room, collapses to vertical when tight.

```dart
LayoutGroup.row(
  [widget1, widget2, widget3],
  minChildWidth: 40,     // nullable, default: 20 (20× baseSpacing)
  fallbackSpacing: 2,    // nullable, defaults to 1 (1× baseSpacing)
)
```

Uses `LayoutBuilder` internally. Divides available width by number of children minus spacing. If any child would get less than `minChildWidth × baseSpacing`, the entire row collapses to vertical. Children are `Expanded` (equal flex) in horizontal mode.

### LayoutGroup.grid

Auto-column count based on min item width.

```dart
LayoutGroup.grid(
  minItemWidth: 35,
  children: cards,
)
```

Column count = `availableWidth ~/ (minItemWidth × baseSpacing)`. Continuous — no breakpoints. Items fill left-to-right, equal width. Spacing between items is `baseSpacing` in both axes.

### Nesting

Groups nest freely:

```dart
LayoutGroup.col([
  LayoutGroup.row([
    LayoutGroup.col([profileHeader, bio]),
    LayoutGroup.col([statsList, actionButtons]),
  ]),
  LayoutGroup.grid(minItemWidth: 35, children: postCards),
])
```

Each group reads its own parent's constraints via `LayoutBuilder`. Works at any nesting depth, in any container.

## Spacing

### Default spacing

Between children in any group: `1 × baseSpacing` (or `fallbackSpacing` if set on the group).

### Explicit spacing

App-defined spacing widgets (`HSpace`, `VSpace`) implement the package's `ResponsiveSpace` interface:

```dart
abstract class ResponsiveSpace {
  double get size;  // in baseSpacing multiples
  Axis get axis;    // horizontal, vertical
}
```

Drop them between children to override the default gap:

```dart
LayoutGroup.row([
  widget1,
  HSpace(4),   // 4× baseSpacing when side-by-side
  VSpace(2),   // 2× baseSpacing when stacked
  widget2,
])
```

### Axis rules

- In horizontal mode: `HSpace` applies, `VSpace` ignored
- In vertical mode: `VSpace` applies, `HSpace` ignored
- If no matching space widget for current mode: use `fallbackSpacing ?? baseSpacing`

The package does NOT convert between axes. No magic.

## Scope Boundaries

**In scope:**
- `ResponsiveLayoutConfig` (InheritedWidget)
- `LayoutGroup.row()`, `.col()`, `.grid()`
- `ResponsiveSpace` interface

**Out of scope:**
- Spacing widget implementations (app provides these)
- Navigation adaptation (separate concern, separate package)
- Dimension scaling (UiScaler's job)
- Z-axis / layering (Flutter's Stack, Overlay, etc.)

## Package Structure

```
flutter_responsive_layout/
  lib/
    flutter_responsive_layout.dart          — barrel export
    src/
      config/
        responsive_layout_config.dart       — InheritedWidget
      groups/
        layout_group.dart                   — base class + factory constructors
        row_group.dart                      — side-by-side ↔ vertical
        grid_group.dart                     — auto-column
        col_group.dart                      — always vertical
      spacing/
        responsive_space.dart               — interface for app spacing widgets
```
