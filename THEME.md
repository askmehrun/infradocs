# Theme Customization

The `infrabook` theme implements the Noir Matte design system.

## Design tokens

Edit `:root` variables in `themes/infrabook/assets/css/theme.css`:

| Variable | Value | Purpose |
|----------|-------|---------|
| `--bg` | `#0f0f0f` | Flat matte carbon black background |
| `--bg-elev` | `#171717` | Elevated surface (sidebar, cards) |
| `--bg-elev-2` | `#1e1e1e` | Secondary elevation |
| `--border` | `#262626` | Card/table borders |
| `--border-soft` | `#1f1f1f` | Subtle borders |
| `--text` | `#d4d4d4` | Primary text |
| `--text-dim` | `#999` | Secondary text |
| `--text-faint` | `#666` | Footer/caption text |
| `--accent-hue` | `#8a6bd3` | Iris accent (links, focus, active states) |
| `--accent-deep` | `#3a2580` | Deep accent (selection, hover) |
| `--radius` | `12px` | Card border radius |
| `--radius-sm` | `8px` | Small element radius |
| `--sans` | `Inter` | Body font |
| `--mono` | `JetBrains Mono` | Code font |

## Design rules

- **No gradients** — flat colors only
- **No glass effects** — solid backgrounds with borders
- **No link underlines** — highlight only
- **No solid white** — use elevated grays

## Configurable params

Set in `hugo.yaml`:

```yaml
params:
  description: Your documentation description
  author: Your Name
  github: https://github.com/<USERNAME>/<REPO>
```

- `description` — meta description and home page subtitle
- `author` — shown in the sidebar footer
- `github` — GitHub link in the sidebar footer (omitted when absent)

## Shortcodes

Two shortcodes are available:

- `{{</* example */>}}` — matte example block
- `{{</* tip */>}}` — tip callout with title

Usage:

```markdown
{{</* example */>}}
This is an example.
{{</* /example */>}}

{{</* tip */>}}
This is a helpful tip.
{{</* /tip */>}}
```

## Responsive layout

The sidebar collapses to a static row below 900px viewport width. Main content expands to full width.
