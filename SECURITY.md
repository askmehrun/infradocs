# Security Policy

## What Must Never Be Committed

Never commit any of the following to this repository:

- Real infrastructure IP addresses (use RFC 5737 documentation ranges instead)
- Real hostnames, server names, or device names
- Credentials, passwords, API keys, tokens, or secrets
- Private keys, certificates, or SSH keys
- Internal network diagrams with real addressing
- Organization-specific configuration with real values
- Local infrastructure inventories

## RFC 5737 Documentation Ranges

Use only these ranges for IP examples:

- `192.0.2.0/24` (TEST-NET-1)
- `198.51.100.0/24` (TEST-NET-2)
- `203.0.113.0/24` (TEST-NET-3)

## How to Handle Sensitive Information

This repository is a **public documentation template**. It contains no real infrastructure data.

- Sanitize all real-world details before adding content
- Replace real IPs, hostnames, and credentials with placeholder values
- If documenting a real procedure, abstract it so no organization-specific details remain
- When in doubt, leave it out

## Reporting Security Vulnerabilities

If you discover a security vulnerability in InfraDocs templates or documentation:

1. Do not create a public issue
2. Contact the repository maintainer through GitHub
3. Describe the vulnerability and its impact
4. Allow reasonable time for a response before public disclosure

## Accidental Secret Exposure

If a secret is accidentally committed:

1. Treat the secret as compromised — rotate it immediately
2. Remove the secret from the repository history (e.g., `git filter-repo` or BFG Repo-Cleaner)
3. Force-push the cleaned history
4. Audit all commits to confirm no secrets remain

## What Belongs in Public Documentation

- General architecture patterns and concepts
- Sanitized examples using RFC 5737 IP ranges
- Documentation standards and naming conventions
- Runbook templates without real values
- Glossary term definitions

## What Must Remain Private

- Real infrastructure inventories and topologies
- Credentials, keys, and tokens
- Organization-specific hostnames and addresses
- Internal procedures with real system details

## License

This project is licensed under AGPL-3.0-only. See [LICENSE](LICENSE).
