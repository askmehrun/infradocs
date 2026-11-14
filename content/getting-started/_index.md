---
title: Getting Started
description: Introduction, scope, and how to use this documentation.
---

Welcome to InfraDocs, the enterprise-grade infrastructure documentation knowledge base.

This section introduces the documentation framework, its scope, and how to use it.

## What you'll find here

- **Architecture** — Network, compute, storage, and service architecture
- **Infrastructure** — Compute, network, storage, and facilities
- **Platforms** — Virtualization, operating systems, containers, networking, storage, endpoint management, observability
- **Services** — DNS, DHCP, identity, monitoring, backup, software deployment
- **Operations** — Backup and recovery, patch management, monitoring, access management, change management
- **Runbooks** — Provisioning, maintenance, troubleshooting, recovery
- **Standards** — Naming conventions, documentation standards, security standards, network standards
- **Decisions** — Architecture Decision Records (ADRs)
- **Glossary** — Definitions of terms used throughout the documentation

## How to use this documentation

1. Start with the **Architecture** section for an overview of the infrastructure design
2. Review **Standards** before contributing or modifying documentation
3. Use **Runbooks** for operational procedures
4. Look up unfamiliar terms in the **Glossary**

## Archetypes

Create new pages with the appropriate archetype:

```
hugo new services/dns/example.md --kind service
hugo new decisions/0002-example.md --kind adr
hugo new runbooks/maintenance/example.md --kind runbook
```

Validate content with `./scripts/validate-content.sh` before committing.
