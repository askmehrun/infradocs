# AGENTS.md — InfraDocs Project Instructions

## Project Overview

**InfraDocs** — Enterprise-grade infrastructure documentation template/framework.
- **Stack:** Hugo v0.169.0+extended, custom "Noir Matte" theme (infrabook)
- **Output:** GitHub Pages (deployed from `/public` on `master`)

InfraDocs is a general-purpose documentation template for documenting infrastructure, server rooms, data centers, and IT environments. It contains no real infrastructure data — only placeholder content ready to be filled.

---

## Architecture

### Content Structure (Atomic — one data point = one page)

```
content/
├── _index.md                    # Home
├── getting-started/
│   ├── _index.md
│   ├── introduction.md
│   ├── scope.md
│   └── documentation-guide.md
├── architecture/
│   ├── _index.md
│   ├── overview.md
│   ├── network-architecture.md
│   ├── compute-architecture.md
│   ├── storage-architecture.md
│   └── service-dependencies.md
├── infrastructure/
│   ├── _index.md
│   ├── compute/_index.md
│   ├── network/_index.md
│   ├── storage/_index.md
│   └── facilities/_index.md
├── platforms/
│   ├── _index.md
│   ├── virtualization/_index.md
│   ├── operating-systems/_index.md
│   ├── containers/_index.md
│   ├── networking/_index.md
│   ├── storage/_index.md
│   ├── endpoint-management/_index.md
│   └── observability/_index.md
├── services/
│   ├── _index.md
│   ├── dns/_index.md
│   ├── dhcp/_index.md
│   ├── identity/_index.md
│   ├── monitoring/_index.md
│   ├── backup/_index.md
│   └── software-deployment/_index.md
├── operations/
│   ├── _index.md
│   ├── backup-and-recovery.md
│   ├── patch-management.md
│   ├── monitoring.md
│   ├── access-management.md
│   └── change-management.md
├── runbooks/
│   ├── _index.md
│   ├── provisioning/_index.md
│   ├── maintenance/_index.md
│   ├── troubleshooting/_index.md
│   └── recovery/_index.md
├── standards/
│   ├── _index.md
│   ├── naming-conventions.md
│   ├── documentation-standards.md
│   ├── security-standards.md
│   └── network-standards.md
├── decisions/
│   ├── _index.md
│   └── 0001-adr-template.md
└── glossary/
    └── _index.md
```

---

## Theme: Noir Matte (`themes/infrabook/`)

| Property | Value |
|----------|-------|
| Background | `#0f0f0f` (flat matte carbon black, **no gradients**) |
| Accent | `#8a6bd3` (Iris, accessible) — deep `#3a2580` |
| Fonts | Sans: `Inter`, Mono: `JetBrains Mono` |
| Radius | `12px` (`--radius`), `8px` (`--radius-sm`) |
| Sidebar | Fixed `17rem` width, `position: fixed`, height `100vh`, `overflow-y: auto` |
| Layout | Rem/percent responsive, breakpoint `900px` |
| Links | **No underlines ever** — highlight only |
| Active nav | Boxed with faded iris background, text colorized |
| Build | `disableKinds: [taxonomy, RSS, sitemap]`, goldmark unsafe: false |

---

## Hugo Conventions

### Front Matter
```yaml
---
title: "Page Title"
description: "A concise description."
type: service           # optional: default, infrastructure, platform, service, runbook, adr
draft: false            # optional, boolean
weight: 10              # optional, non-negative integer
---
```
- Navigation is determined by Hugo's content hierarchy (where a file lives under `content/`), not by front matter
- **No `draft: true`** — archetypes/default.md has it removed
- No taxonomy, tags, dates
- Section `_index.md` files have only `title` and optional `description`

### Templates (`layouts/`)
- `baseof.html` — shell, sidebar nav, footer; nav logic:
  - Home → list sections
  - Section/leaf → siblings with `active` class via `eq $currentPage.RelPermalink .RelPermalink`
  - Back button at bottom of nav, above footer
  - Title tag: `{{ if not .IsHome }}{{ .Title }} · {{ end }}{{ .Site.Title }}`
- `index.html` — home: `<h1 class="title">{{ .Title }}</h1>` only
- `list.html` — section pages: title + link-list of children
- `single.html` — content pages: title only

### Config (`hugo.yaml`)
```yaml
# Change baseURL to your GitHub Pages URL, e.g. https://<user>.github.io/<repo>/
baseURL: https://<USERNAME>.github.io/<REPO>/
locale: en-us
title: Infra Docs
theme: infrabook

params:
  description: Enterprise-grade infrastructure documentation
  author: Your Name
  github: https://github.com/<USERNAME>/<REPO>

disableKinds:
  - taxonomy
  - RSS
  - sitemap

markup:
  goldmark:
    renderer:
      unsafe: true
  highlight:
    noClasses: false
```

---

## Commands

| Task | Command |
|------|---------|
| Dev server (live reload) | `hugo server --bind 0.0.0.0 --port 1313 --disableFastRender` |
| Production build | `hugo --gc --minify` |
| Clean build | `rm -rf public && hugo --gc --minify` |

---

## Git / GitHub Pages Workflow

1. **Source on `master`** — content + theme + config only
2. **Build locally** → `hugo --gc --minify` → output in `/public/`
3. **GitHub Pages** serves from `/public` on `master` branch
4. **Commit strategy**: small, atomic commits
5. **No `.claude/` in repo** — excluded via `.gitignore`

### Commit Message Style
- **Short, imperative, human** — "fix: remove gradients from theme", "add: DNS service documentation"
- No verbose descriptions, no attribution lines
- One logical change per commit

---

## Content Rules (Template)

- **General only** — no real infrastructure names, IPs, or data
- **Atomic pages** — one data point per page
- **Tables carry the info** — descriptions only where table is insufficient
- **No placeholder "To be documented" pages** in production releases
- **RFC 5737 IP ranges** for examples only (`192.0.2.0/24`, `198.51.100.0/24`)
- **No real infrastructure data** — this is a template/framework

---

## Release Checklist

- [ ] `hugo --gc --minify` builds clean, 0 errors
- [ ] No real infrastructure names or IPs in content
- [ ] No duplicate H1s on any page
- [ ] Active nav state correct on all page types
- [ ] No link underlines
- [ ] No gradients in CSS
- [ ] All links use Hugo `relref` for subpath safety

---

## Quick Reference for Agents

| Question | Answer |
|----------|--------|
| How to add a new page? | Create `.md` in correct section with `title` front matter (Hugo hierarchy sets navigation) |
| How to modify nav? | Edit `baseof.html` nav logic |
| How to change theme colors? | Edit CSS variables in `theme.css` `:root` |
| How to rebuild? | `hugo --gc --minify` |
| How to preview? | `hugo server --bind 0.0.0.0 --port 1313 --disableFastRender` |
| Where is GitHub Pages config? | Settings → Pages → Source: `master` / `/public` |

---

## Do Not

- Commit `.claude/`, `public/`, `.hugo_build.lock`, `/cache/`, `/resources/`
- Add gradients, glass effects, link underlines, solid white
- Write real infrastructure data (names, IPs, hostnames, credentials)
- Write prose where a table suffices
- Use verbose/robotic commit messages

---

*This file is the single source of truth for agents working on InfraDocs. Keep it current.*