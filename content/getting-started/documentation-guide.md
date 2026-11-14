---
title: Documentation Guide
description: Complete onboarding path for new InfraDocs users.
---

# Documentation Guide

This guide walks you through setting up, using, validating, building, and deploying InfraDocs from scratch.

## 1. Clone the repository

```bash
git clone https://github.com/<YOUR_USERNAME>/<YOUR_REPO>.git
cd <YOUR_REPO>
```

## 2. Install Hugo

Install Hugo v0.169.0+extended (required by the `infrabook` theme):

```bash
# macOS
brew install hugo

# Linux (Debian/Ubuntu)
sudo apt-get install hugo

# Or download from https://gohugo.io/install/
```

Verify:

```bash
hugo version
# Hugo Static Site Generator v0.169.0+extended linux/amd64 BuildDate=unknown
```

## 3. Configure hugo.yaml

Edit `hugo.yaml` with your values:

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

## 4. Run the local development server

```bash
hugo server --bind 0.0.0.0 --port 1313 --disableFastRender
```

Open `http://localhost:1313/`.

## 5. Create a new document

Use the appropriate archetype for your content type:

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

Each archetype sets the correct `type` front matter. Navigation is determined by where the file lives under `content/`.

## 6. Write and organize content

- **Atomic pages** — one data point per page
- **Tables carry the info** — descriptions only where a table is insufficient
- **No placeholder "To be documented" pages** in production releases
- **RFC 5737 IP ranges only** for examples: `192.0.2.0/24`, `198.51.100.0/24`
- **No real infrastructure data** — no real IPs, hostnames, or credentials

## 7. Run validation

```bash
./scripts/validate-content.sh
./scripts/validate-links.sh
```

Or run the full suite:

```bash
./scripts/validate.sh
```

## 8. Build the site

```bash
hugo --gc --minify
```

Output goes to `public/`.

## 9. Deploy to GitHub Pages

1. Push your source to the `master` branch
2. In GitHub repo **Settings → Pages**, set:
   - **Build and deployment → Source:** `GitHub Actions`
3. The included workflow (`.github/workflows/deploy.yml`) builds, validates, and deploys automatically

Your site is live at `https://<YOUR_USERNAME>.github.io/<YOUR_REPO>/`.

## Archetypes at a glance

| Archetype | Use for |
|-----------|---------|
| `default` | General documentation pages |
| `infrastructure` | Compute, network, storage, facilities components |
| `platform` | Virtualization, OS, containers, networking, storage platforms |
| `service` | DNS, DHCP, identity, monitoring, backup, deployment services |
| `runbook` | Step-by-step operational procedures |
| `adr` | Architecture Decision Records |
