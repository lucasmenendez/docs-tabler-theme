---
title: Use as a GitHub Action
layout: default
permalink: /docs/usage/action/
nav_title: GitHub Action
nav_level: 2
nav_parent: Docs
nav_order: 2
nav_icon: github
---

# Use as a GitHub Action

Docs Tabler Theme also ships as a **composite GitHub Action** that builds a Jekyll site from a bare Markdown folder and exposes the static files. A consuming repo needs no Gemfile, no `_config.yml`, and no Ruby knowledge, since the action generates the Jekyll scaffold and builds with a `path:` reference to the theme, independent of GitHub Pages' gem whitelist.

## Consumer workflow

Put this in `.github/workflows/pages.yml`:

```yaml
name: Deploy GitHub Pages
on:
  push:
    branches: ["main"]
  workflow_dispatch:
permissions:
  contents: read
  pages: write
  id-token: write
concurrency:
  group: "pages"
  cancel-in-progress: false
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: actions/configure-pages@v6
        id: pages
      - uses: lucasmenendez/docs-tabler-theme@main
        with:
          content-path: docs
          title: My Docs
          baseurl: ${{ steps.pages.outputs.base_path }}
      - uses: actions/upload-pages-artifact@v5
        with:
          path: _site
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v5
```

The `content-path` folder needs only the content itself: Markdown pages, an optional `_nav/` and `_footer/`. A `search.json` is created automatically if missing.

Then enable **Settings → Pages → Source: GitHub Actions**.

{: .note }
> The example uses `@main`. For a stable build, pin the action to a release tag, e.g. `lucasmenendez/docs-tabler-theme@v1.0.0`. The theme always matches the action version, so a tagged consumer builds with the matching theme.

## Inputs

| Input            | Default   | Description |
| ---------------- | --------- | ----------- |
| `content-path`   | `.`       | Folder with the Markdown content (recursive) + optional `_nav/`. |
| `checkout`       | `true`    | Whether to run `actions/checkout` on the repo before building. Set to `false` when you've already checked out and generated content before this step (e.g. swagger UI assets), since the action's own checkout would clean away untracked files. |
| `title`          | `Docs`    | Site title. |
| `description`    | —         | Meta description. |
| `logo`           | —         | Light-mode logo path relative to the built site root. |
| `logo-dark`      | —         | Dark-mode logo path (optional; if omitted, `logo` is used in both modes). |
| `favicon`        | —         | Favicon path relative to the built site root (`.ico`, `.png`, or `.svg`); defaults to the theme's logo.svg. |
| `theme`          | `both`    | Color theme mode: `both` (default) shows a navbar toggle between light and dark, `light` and `dark` fix the site to that scheme and hide the toggle. |
| `baseurl`        | —         | Base URL (`base_path` from the configure-pages step for project sites; empty for user pages). |
| `theme-path`     | —         | Local theme path (testing or self-hosting, e.g. `.`); when empty the action builds with its own files, so the theme always matches the action version. |
| `ruby-version`   | `3.1`     | Ruby version for the build. |
| `jekyll-version` | `~> 4.3`  | Jekyll version constraint. |
| `output-path`    | `_site`   | Where the built site is written. |
| `config`         | —         | Optional extra Jekyll config file (merged on top). |
| `static-path`    | —         | Static content to publish verbatim: a single file (kept under its own basename) or a folder of assets. Copied into the built site at `static-dest`. |
| `static-dest`    | —         | Target folder inside the built site (e.g. `api`, served at `/api/`); a single file keeps its basename. **Required when `static-path` is set.** |
| `trace`          | `false`   | Pass `--trace` to Jekyll. |

## Outputs

`build-path`: the absolute path to the built site, for example for `upload-pages-artifact`.

## Logos

Put the logo images anywhere inside your `content-path` folder and pass both inputs:

```yaml
- uses: lucasmenendez/docs-tabler-theme@main
  with:
    content-path: docs
    logo: /assets/images/logo.svg
    logo-dark: /assets/images/logo-dark.svg
```

The files are copied with the content and served at those root-relative paths; the navbar swaps them via the theme toggle.

## Favicon

Put a favicon anywhere inside your `content-path` folder and pass its path to render it in the browser tab:

```yaml
- uses: lucasmenendez/docs-tabler-theme@main
  with:
    content-path: docs
    favicon: /assets/images/favicon.ico
```

Accepts `.ico`, `.png`, or `.svg`. If omitted, the theme's own logo is used as the favicon.

## Theme

Control the color scheme with the `theme` input:

```yaml
- uses: lucasmenendez/docs-tabler-theme@main
  with:
    content-path: docs
    theme: dark    # both (default), light, or dark
```

With `both` (the default) a light/dark toggle is shown in the navbar and the visitor's choice is remembered in `localStorage` (falling back to their OS preference). With `light` or `dark` the site is fixed to that scheme and the toggle is hidden.

## Publish static content

To serve generated static content alongside the docs (for example a swagger UI site), point `static-path` at it and give it a target path with `static-dest`. The files are copied **verbatim** into the built site after the Jekyll build (no Liquid processing, no search-index entry, no TOC/nav interference).

```yaml
- uses: lucasmenendez/docs-tabler-theme@main
  with:
    content-path: docs
    checkout: false             # keep the generated docs/api assets
    static-path: docs/api       # a folder of swagger-ui assets…
    static-dest: api            # …served at /api/
```

`static-path` accepts a single file (copied into `<dest>/` under its own basename, so `static-path: scripts/preview.sh` + `static-dest: sh` is served at `/sh/preview.sh`) or a folder (its contents copied into `<dest>/`). `static-dest` is required whenever `static-path` is set. Reference the result from your docs with the Jekyll URL filter:

```markdown
[API reference]({{ '/api/' | relative_url }})
```

{: .note }
> The action normally checks out the repository itself (via the `checkout` input, default `true`), and that checkout would delete untracked generated files. When you generate static content before this step (as the swagger UI example does), set `checkout: false` so the files you created are kept.

## Local build (testing the action logic)

```bash
CONTENT_PATH=docs THEME_PATH=. OUTPUT_PATH=/tmp/pages-out ./scripts/build.sh
```

## Hosting this repo's own docs

This site is built and deployed by the action itself, see `.github/workflows/pages.yml` in this repository. It uses `uses: ./` with `theme-path: .` (this repo *is* the theme), `content-path: docs`, and the Pages base path.