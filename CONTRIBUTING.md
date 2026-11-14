# Contributing to InfraDocs

## How to contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Add documentation pages using the appropriate archetype:
   ```
   hugo new services/dns/example.md --kind service
   hugo new decisions/0002-example.md --kind adr
   hugo new runbooks/maintenance/example.md --kind runbook
   ```
4. Validate content: `./scripts/validate-content.sh`
5. Commit with a short, human message
6. Push and open a pull request

## Content guidelines

- One data point per page (atomic documentation)
- Tables carry the information; descriptions only where needed
- No placeholder "To be documented" pages in production
- Use RFC 5737 documentation IP ranges (`192.0.2.0/24`, `198.51.100.0/24`) for examples
- No real infrastructure IPs or sensitive data

## Commit message style

Short, imperative, human-readable:

- `add: DNS service documentation`
- `fix: sanitize real IPs to RFC 5737 ranges`
- `feat: add runbook archetype`

No verbose descriptions, no attribution lines.
