# BILA brand notes

## Official logo

- File: `apps/dashboard/public/brand/bila-logo-official.jpeg`. It is byte-identical to the file the owner supplied (originally `IMG_2818.jpeg`).
- SHA-256: `30f3a98ea6dcd1c20621a09993fa6f24b2e68c0711ec4822e0f2c1ecc7ef17c7`
- `bash scripts/check-brand.sh` verifies this locally, and CI runs it on every push.

### Measured from the file (2026-11-05)

| Property | Value |
| --- | --- |
| Format | JPEG, 843 x 842 px (treated as square) |
| Origin | iPhone screenshot (EXIF description "Screenshot"), not a master file |
| Colour profile | Display P3 embedded |
| Background | Flat blue. Raw file value `#0500F3`; converted to sRGB `#0600FD` |
| Transparency | None |
| Mark colour | White (median of near-white pixels `#FEFEFE`) |
| Mark shape | A white hash-style grid (two horizontal and two vertical bars) whose crossings are softened with large concave curves. This leaves a circular opening at the centre and four rounded notches (top, bottom, left, right). Bar ends are cut square. |
| Mark size | 612 x 610 px: 72.6% of the tile width, with 13.4% to 14.0% margin on each side |

The blue may have been authored as pure `#0000FF`; the measured value is within a few levels of it. Confirm with the designer. Until then the UI uses the measured value so the tile and the interface blue match on screen.

## Usage rules

1. Never redraw, recolour, recrop, add effects to, or re-encode the official file. Derived sizes (favicon, app icon) must be uniform resizes of the whole square.
2. Show the full square tile. It carries its own margin. Keep it square (`object-fit: contain` inside a square box). Suggested minimum size: 24 CSS px; review on a real phone.
3. Place the tile on white or on the brand blue so its square edge never looks accidental.
4. Replace the logo only with a new official file from the owner: update `scripts/brand.sha256` and this file in the same commit.

## Interface tokens (derived from the measured logo colours)

Contrast ratios are computed with the WCAG relative-luminance formula. White on the brand blue is 8.66:1.

| Token | Value | Role | Contrast |
| --- | --- | --- | --- |
| `--bila-blue` | `#0600FD` | Brand. Primary actions, links, focus ring, logo tile | 8.66:1 on white, 8.03:1 on surface |
| `--bila-white` | `#FFFFFF` | Logo mark colour; page background; text on blue | n/a |
| `--bila-ink` | `#0A0A2E` | Primary text (blue-black, hue-aligned with the brand) | 19.16:1 on white, 17.77:1 on surface |
| `--bila-muted` | `#55577A` | Secondary text | 6.93:1 on white, 6.42:1 on surface |
| `--bila-surface` | `#F5F6FC` | Page and section background | n/a |
| `--bila-line` | `#DCDEEE` | Decorative dividers only | n/a |
| `--bila-line-strong` | `#7C7FA3` | Input and control boundaries (needs 3:1 against white) | 3.87:1 on white |

### Transaction status colours

Never rely on colour alone: every status chip also carries its text label and a distinct icon shape. Rejected (policy said no) and Failed (settlement did not complete) must be visibly different at a glance.

| Status | Text colour | On white | On surface |
| --- | --- | --- | --- |
| Pending | `#8A5300` | 6.33:1 | 5.87:1 |
| Approved | `#0600FD` | 8.66:1 | 8.03:1 |
| Settled | `#0B6B3F` | 6.58:1 | 6.11:1 |
| Rejected | `#B3261E` | 6.54:1 | 6.06:1 |
| Failed | `#9C1F6B` | 7.44:1 | 6.90:1 |
| Expired | `#5F6280` | 5.92:1 | 5.49:1 |

## Direction for the dashboard (M5)

- Spend the boldness in one place: the brand blue and one signature element, everything else quiet and neutral.
- Signature element (proposal): an agent limits gauge. The mark's four notches around a central circle map naturally to an agent's four limits (per transaction, day, week, month) around its treasury. This is a UI idea inspired by the logo; the logo itself is never altered.
- Money and identifiers (amounts, account ids, payment ids) use tabular figures and never wrap mid-value.
- Typeface: to be chosen at M5 after checking candidates on a real phone. Requirements: tabular figures, open licence, good small-size legibility.
- Mobile Safari first: one column, thumb-reachable actions, no hover-only information.

## Open items

- Ask the owner for an original vector or large PNG of the logo. The screenshot JPEG is fine for the navigation tile and favicon but will look soft at large sizes.
