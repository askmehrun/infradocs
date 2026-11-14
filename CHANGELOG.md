# Changelog

## [v0.0.2-alpha] — 2026-11-14

### Stabilization, Quality, and Usability Release

This release makes the existing InfraDocs framework reliable, reproducible, and properly documented. No new features were added.

### Changes

**Repository hygiene**
- Tightened `.gitignore` to exclude env files, credentials, temp files, IDE files, and `.claude/`
- No generated or local build artifacts tracked

**Hugo configuration**
- Disabled `goldmark` unsafe renderer (`unsafe: false`) — no content depends on raw HTML
- Kept sitemap disabled (per project decision)
- Confirmed subpath-safe baseURL handling for root and repository-subpath deployments

**Content architecture**
- Removed `parent` front matter from all content and archetypes — Hugo's content hierarchy is the canonical navigation source
- Added `description` to all ten section `_index.md` files
- Added Phase 3.5 prose to each section explaining contents, scope, archetype, and relations
- Added Glossary to the homepage navigation
- Verified all 50 content pages have valid front matter

**Archetypes**
- Rewrote all six archetypes (`default`, `infrastructure`, `platform`, `service`, `runbook`, `adr`) with consistent, useful structures
- ADR archetype supports statuses: proposed, accepted, rejected, deprecated, superseded
- All archetypes generate valid Markdown with valid front matter

**Theme fixes (infrabook / Noir Matte)**
- Fixed `.site-main` width to `calc(100% - 17rem)` — no horizontal overflow
- Changed link color from `#5d3fd3` to `#8a6bd3` for WCAG AA contrast (4.5:1) on `#0f0f0f`
- Added Google Fonts @import for Inter and JetBrains Mono
- Added `.example` and `.tip` shortcode CSS styling with `.tip-title`
- Added `.site-footer` styling with conditional GitHub link
- Included `footer.html` partial in `baseof.html`
- Added `tabindex="-1"` to `#main` for skip-to-content keyboard focus
- Verified active nav states on homepage, sections, and content pages
- Verified responsive sidebar below 900px

**Validation tooling**
- Added `scripts/validate-content.py` — recursive YAML front matter parser with title, type, draft, weight checks
- Updated `scripts/validate-content.sh` as entry point to the Python validator
- Rewrote `scripts/validate-links.sh` — builds site, checks internal and relative links, skips external/placeholder URLs
- Added `scripts/validate.sh` — unified validation: content → lint → build → links

**CI/CD**
- Split `.github/workflows/deploy.yml` into validation job (runs on PRs and pushes) and deploy job (runs on master only)
- Pinned all third-party GitHub Actions to full commit SHAs
- Added gitleaks secret scanning to CI
- Added `workflow_dispatch` for manual execution
- PRs validate but do not deploy

**Documentation**
- Rewrote README with correct GitHub Pages source instructions (GitHub Actions, not public/ branch)
- Added `content/getting-started/documentation-guide.md` — complete onboarding path
- Added `ARCHETYPES.md` — archetype usage guide
- Added `THEME.md` — theme customization guide
- Added `TROUBLESHOOTING.md` — common issues and fixes
- Expanded `SECURITY.md` — never-commit list, RFC 5737 ranges, accidental exposure handling
- Synced `AGENTS.md` with all convention changes

### Breaking Changes

- `parent` front matter field removed from all archetypes and content pages (navigation now uses Hugo content hierarchy)
- Link color changed from `#5d3fd3` to `#8a6bd3`

### Known Limitations

- Fonts rely on Google Fonts @import (system font stacks are fallbacks)
- No sitemap generated (intentionally disabled)
