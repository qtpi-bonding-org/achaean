# Achaean UI Theme Design

## Identity

Athenian civic aesthetic — the app feels like civic infrastructure, not a startup. The agora is a public square, poleis are city-states, trust declarations are civic acts. The UI should feel like stone, not plastic. Mythology sprinkled in as seasoning (logo, empty states, future custom icons) but the foundation is monumental and institutional.

## Typography

- **Headers:** Cinzel — inscriptional, monumental, carved-in-stone presence
- **Body:** League Spartan — geometric, sturdy, built-to-last foundation
- **Font weights:** Heavy (Cinzel headers), Medium (League Spartan body), Light (League Spartan secondary text)
- **Font files:** stored in `assets/fonts/`

## Color Palette

| Role | Light | Dark (inverted stone) |
|------|-------|-----------------------|
| Background | #F5F0E8 (limestone) | #1E1D1B (dark slate) |
| Surface | #EDE8DE (deeper stone) | #2A2823 (warm dark) |
| Text primary | #2A2A2A (charcoal) | #E8E2D8 (light stone) |
| Text secondary / borders | #9B9083 (weathered stone) | #7A7166 (muted stone) |
| Accent primary | #C4602D (terracotta) | #C4602D (terracotta) |
| Accent highlight | #B8973A (muted gold) | #B8973A (muted gold) |
| Error | #8B3A2A (burnt terracotta) | #C4602D (terracotta) |
| Success | #5C6B3C (olive) | #7A8F5A (lighter olive) |

Accents stay the same across modes. The stone inverts, the decoration doesn't.

## Iconography

Material Icons throughout, styled with consistent sizing and palette coloring. Custom logo for the app icon (Greek-inspired, designed separately).

## Implementation

Swap values in three existing files — no structural changes to the design system:
- `app_palette.dart` — new color values for light and dark palettes
- `app_fonts.dart` — Cinzel + League Spartan, updated weight names
- `app_theme.dart` — wire new palette/fonts through Material theme
