# InfraDocs

Enterprise-grade infrastructure documentation framework — a Hugo static site template for documenting server rooms, data centers, networks, and IT environments.

InfraDocs is a **general-purpose documentation framework**, not a site for one organization. It contains no real infrastructure data — only placeholder content and structure ready to be filled with your own.

---

## What's included

| Component | Purpose |
|-----------|---------|
| **Hugo static site** | Fast, secure, no-database documentation site |
| **infrabook theme** | Noir Matte design — flat `#0f0f0f` carbon-black background, Iris `#5d3fd3` accent, no gradients, no glass |
| **Atomic content structure** | One data point = one page, organized by section |
| **6 archetypes** | `default`, `infrastructure`, `platform`, `service`, `runbook`, `adr` |
| **10 content sections** | Architecture, Infrastructure, Platforms, Services, Operations, Runbooks, Standards, Decisions, Glossary, Getting Started |
| **GitHub Actions** | Auto-deploy to GitHub Pages on push to `master` |
| **Fixed sidebar nav** | Always-visible navigation with active state and "Back one level" button |
| **No build kinds** | Taxonomy, RSS, and sitemap disabled for a minimal build |

---

## Quick start

### 1. Fork and clone

```bash
git clone https://github.com/<YOUR_USERNAME>/<YOUR_REPO>.git
cd <YOUR_REPO>
```

### 2. Configure for your site

Edit `hugo.yaml`:

```yaml
baseURL: https://<YOUR_USERNAME>.github.io/<YOUR_REPO>/
locale: en-us
title: Your Docs Title
theme: infrabook

params:
  description: Your documentation description
  author: Your Name
  github: https://github.com/<YOUR_USERNAME>/<YOUR_REPO>
```

- `baseURL` — your GitHub Pages URL (required for correct subpath links)
- `title` — appears in the browser tab and sidebar brand
- `author` — shown in the sidebar footer
- `github` — link in the sidebar footer

### 3. Add content

Use the archetypes to create new pages:

```bash
# A service page
hugo new services/dns/internal.md --kind service

# A runbook
hugo new runbooks/maintenance/patching.md --kind runbook

# An Architecture Decision Record
hugo new decisions/0002-database-choice.md --kind adr

# A platform page
hugo new platforms/virtualization/proxmox.md --kind platform

# Generic page
hugo new getting-started/welcome.md --kind default
```

Each archetype sets the correct `parent` and `type` front matter so the page appears in the right section of the sidebar navigation.

### 4. Preview locally

```bash
hugo server --bind 0.0.0.0 --port 1313 --disableFastRender
```

Open `http://localhost:1313/`.

### 5. Build for production

```bash
hugo --gc --minify
```

Output goes to `public/`.

### 6. Deploy to GitHub Pages

1. Push your source to the `master` branch
2. In GitHub repo **Settings → Pages**, set:
   - **Source:** Deploy from a branch
   - **Branch:** `master`
   - **Folder:** `/public`
3. Your site is live at `https://<YOUR_USERNAME>.github.io/<YOUR_REPO>/`

Or use the included GitHub Actions workflow (`.github/workflows/deploy.yml`) which builds and deploys automatically on every push to `master`.

---

## Content structure

```
content/
├── _index.md                    # Home page
├── getting-started/             # Introduction, scope, docs guide
├── architecture/                # Network, compute, storage, service architecture
├── infrastructure/              # Compute, network, storage, facilities
├── platforms/                   # Virtualization, OS, containers, networking, storage
├── services/                    # DNS, DHCP, identity, monitoring, backup, deployment
├── operations/                  # Backup, patching, monitoring, access, change mgmt
├── runbooks/                    # Provisioning, maintenance, troubleshooting, recovery
├── standards/                   # Naming, documentation, security, network standards
├── decisions/                   # Architecture Decision Records (ADRs)
└── glossary/                    # Term definitions
```

Each section has an `_index.md` section page. Child pages use `parent: Section Name` in front matter to appear in the sidebar under that section.

---

## Content rules

- **Atomic pages** — one data point per page, no redundant prose
- **Tables carry the info** — descriptions only where a table is insufficient
- **No real infrastructure data** — this is a template, not a live inventory
- **No placeholder "To be documented" pages** in production releases
- **RFC 5737 IP ranges only** for examples: `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24`
- **No real hostnames, credentials, or IPs** — sanitize everything before publishing

---

## Theme: infrabook (Noir Matte)

Custom Hugo theme by Mehran Askarnezhad.

| Property | Value |
|----------|-------|
| Background | `#0f0f0f` flat matte carbon black |
| Accent | `#5d3fd3` Iris (faded `#8a6bd3`, deep `#3a2580`) |
| Sidebar | Fixed width, never scrolls with content |
| Links | No underlines — highlight only |
| Active nav | Boxed with faded iris background |
| Build | Minimal — no taxonomy, RSS, or sitemap |

Customize colors in `themes/infrabook/assets/css/theme.css` (`:root` variables).

---

## Commands

| Task | Command |
|------|---------|
| Dev server (live reload) | `hugo server --bind 0.0.0.0 --port 1313 --disableFastRender` |
| Production build | `hugo --gc --minify` |
| Clean build | `rm -rf public && hugo --gc --minify` |
| Validate content | `./scripts/validate-content.sh` |
| Validate links | `./scripts/validate-links.sh` |

---

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/validate-content.sh` | Checks all markdown files have valid front matter |
| `scripts/validate-links.sh` | Checks generated HTML for root-absolute links that break on subpath |

---

## License

[AGPL v3](LICENSE)

GNU Affero General Public License v3.0 — if you run this as a network service and modify it, you must offer users the Corresponding Source.

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Add or improve documentation pages
4. Commit with short, human messages (e.g. `add: DNS service archetype`)
5. Push and open a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for full guidelines.

---

## Security

Never commit real infrastructure IPs, hostnames, credentials, or sensitive configuration. Use RFC 5737 documentation ranges for IP examples. See [SECURITY.md](SECURITY.md).

---

*Built with [Hugo](https://gohugo.io/) and the [infrabook](https://github.com/askmehrun/infradocs/tree/master/themes/infrabook) theme by Mehran Askarnezhad.*