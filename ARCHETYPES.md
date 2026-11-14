# Archetype Guide

InfraDocs provides six archetypes for creating documentation pages. An archetype is a template that `hugo new` uses to scaffold a new Markdown file with the correct front matter.

## Available Archetypes

| Archetype | File | Use for |
|-----------|------|---------|
| `default` | `archetypes/default.md` | General documentation pages |
| `infrastructure` | `archetypes/infrastructure.md` | Compute, network, storage, facilities components |
| `platform` | `archetypes/platform.md` | Virtualization, OS, containers, networking, storage platforms |
| `service` | `archetypes/service.md` | DNS, DHCP, identity, monitoring, backup, deployment services |
| `runbook` | `archetypes/runbook.md` | Step-by-step operational procedures |
| `adr` | `archetypes/adr.md` | Architecture Decision Records |

## Creating a Document

```bash
hugo new <section>/<page>.md --kind <archetype>
```

Examples:

```bash
hugo new services/dns/internal.md --kind service
hugo new decisions/0002-example.md --kind adr
hugo new runbooks/maintenance/patching.md --kind runbook
hugo new platforms/virtualization/proxmox.md --kind platform
```

## Supported Front Matter

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | Yes | Page title |
| `description` | string | No | Concise page description |
| `type` | string | No | One of: default, infrastructure, platform, service, runbook, adr |
| `draft` | boolean | No | Whether the page is a draft |
| `weight` | integer | No | Non-negative sort weight |

## Content Hierarchy

Navigation is determined by Hugo's content hierarchy — where a file lives under `content/` — not by front matter. Place a page in the section folder that matches its topic, and Hugo will show it in that section's sidebar navigation.

## Customizing an Archetype

Edit the archetype file under `archetypes/` to change the scaffolded structure. All archetypes generate valid Markdown with valid front matter by default.
