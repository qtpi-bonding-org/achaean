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

Material Icons throughout, styled with consistent sizing and palette coloring.

## Logo

Direction: stylized coin motif — represents community identity and shared agreement. Details TBD. Possibilities include abstracted owl, column, or letterform inside a coin shape. Should read as "civic seal" not "historical artifact."

## Note on Naming

"Achaean" and the Greek vocabulary (poleis, agora, politai) are structural inspiration — the architecture of civic participation, not an endorsement of ancient ethics. Keep the Greek flavor in the product structure, don't lean too hard on it in marketing or branding.

## Design Rules

The UI should feel **carved, not assembled.** Stone has depth through relief (raised/recessed surfaces), not through floating layers and drop shadows.

1. **No FABs** — Actions go in the app bar or inline. Nothing floats.
2. **No elevation shadows** — Use subtle border lines or slight color shifts for depth. Stone doesn't cast shadows on itself.
3. **No pill-shaped buttons** — Square or slightly rounded corners only. Stone has clean edges.
4. **No outline buttons** — Use filled (terracotta) for primary actions, flat/text for secondary. An outlined button on stone looks like a wireframe, not a carving.
5. **Minimal color fills** — Let the stone background breathe. Terracotta and gold are accents, not backgrounds. Most of the screen is limestone.
6. **Dividers over cards** — Separate content with horizontal lines (like entablature bands) rather than boxing everything in cards.
7. **Text hierarchy does the work** — Cinzel headers at different sizes create structure. No colored banners or container backgrounds needed to organize content.

## Widget Library

Standardized widgets that enforce the design rules. All screens compose from these — no ad-hoc styling.

### Layout
- **AchaeanScaffold** — App scaffold with stone background, optional app bar with Cinzel title
- **StoneDivider** — Horizontal line in weathered stone color, used to separate content sections
- **EntablatureHeader** — Section header: Cinzel title + optional subtitle + stone divider below

### Actions
- **TerracottaButton** — Filled primary action button. Terracotta background, limestone text, square corners.
- **FlatTextButton** — Secondary action. No background, terracotta or charcoal text.

### Content
- **InscriptionTile** — List item with Cinzel title + League Spartan subtitle, separated by stone dividers (not cards)
- **ReliefCard** — For when you truly need a card (e.g., post preview). Subtle stone border, no shadow, slight surface color shift.

### Feedback
- **StoneSnackBar** — Feedback messages styled in palette (success=olive, error=burnt terracotta). No Material default styling.

### Input
- **ChiseledTextField** — Text input with stone-colored border, terracotta focus border, square corners.

## Implementation

Swap values in three existing files — no structural changes to the design system:
- `app_palette.dart` — new color values for light and dark palettes
- `app_fonts.dart` — Cinzel + League Spartan, updated weight names
- `app_theme.dart` — wire new palette/fonts through Material theme

Build widget library in `design_system/widgets/` — screens compose from these widgets exclusively.
