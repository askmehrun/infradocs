# Troubleshooting

Common issues and fixes for InfraDocs.

## Hugo version mismatch

**Symptom:** Build fails or theme features missing.

**Fix:** Install Hugo v0.169.0+extended (required by `theme.toml` `min_version`).

```bash
hugo version
# Hugo Static Site Generator v0.169.0+extended
```

## Theme not found

**Symptom:** Build error "unable to find layout" or unstyled site.

**Fix:** Confirm `theme: infrabook` in `hugo.yaml` and that `themes/infrabook/` exists.

## Invalid front matter

**Symptom:** `./scripts/validate-content.sh` reports missing front matter or malformed YAML.

**Fix:** Every page must start with `---` and end with a closing `---`. Title is required.

```yaml
---
title: My Page
description: A description.
---
```

## Incorrect baseURL

**Symptom:** Links or assets 404 on GitHub Pages subpath.

**Fix:** Set `baseURL` to your full GitHub Pages URL:

```yaml
baseURL: https://<USERNAME>.github.io/<REPO>/
```

All theme asset paths use `RelPermalink`/`relURL`, so they work at root or subpath.

## Broken internal links

**Symptom:** `./scripts/validate-links.sh` reports missing targets.

**Fix:** Use Hugo `relref` shortcode or relative links. Avoid root-absolute paths (`/page/`) that break on subpath.

## GitHub Pages deployment failure

**Symptom:** Pages deploy fails or shows old content.

**Fix:**
- Confirm **Settings → Pages → Source: GitHub Actions**
- Confirm the deploy workflow runs on push to `master`
- Check the Actions tab for validation failures (deployment only runs after validation passes)

## Missing assets

**Symptom:** CSS or JS not loading.

**Fix:** Confirm `themes/infrabook/assets/css/theme.css` and `themes/infrabook/static/js/main.js` exist. Hugo fingerprints and minifies them automatically.

## Repository-subpath deployment

**Symptom:** Site works at root but breaks under `https://<user>.github.io/<repo>/`.

**Fix:** Set `baseURL` to the subpath URL. Never use `relativeURLs: true`. All internal links must use Hugo `RelPermalink` or `relURL`.
