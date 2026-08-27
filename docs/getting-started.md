---
title: Getting started
layout: default
permalink: /getting-started/
nav_title: Getting started
nav_level: 1
nav_order: 2
nav_icon: zap
---

# Getting started

Docs Tabler Theme can be used two ways. Pick the one that fits your setup:

1. **As a Jekyll theme**, which you use when you have a Jekyll site (or want one) and manage your own build.
2. **As a GitHub Action**, where you only write Markdown and the action builds and deploys to GitHub Pages for you.

Both use the same content: plain Markdown files with optional `_nav/` and `_footer/` folders.

## Quick start with the GitHub Action

This is the fastest path if your docs live in a GitHub repository.

1. Put your Markdown pages in a folder, for example `docs/`.
2. Add a workflow at `.github/workflows/pages.yml`:

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

3. Enable **Settings → Pages → Source: GitHub Actions**.

{: .success }
> Done. Every push to `main` rebuilds and deploys your docs. See the [GitHub Action]({{ '/usage/action/' | relative_url }}) page for all inputs.

## Quick start as a Jekyll theme

Requires [Ruby](https://www.ruby-lang.org) and [Jekyll](https://jekyllrb.com/docs/installation/), or skip both and preview with Docker (step 4).

1. Add the theme to your `Gemfile`:

```ruby
gem "docs-tabler-theme", github: "lucasmenendez/docs-tabler-theme"
```

2. Enable it in `_config.yml`:

```yaml
theme: docs-tabler-theme
```

3. Create your first page, `index.md`:

```markdown
---
layout: home
---

# Hello docs
```

4. Serve (the quickest way needs only Docker, no Ruby):

```bash
curl -fsSL https://lucasmenendez.github.io/docs-tabler-theme/sh/preview.sh | bash
```

Serves the current directory at <http://localhost:4000> with live reload (`SITE` and `PORT` override the defaults; live reload runs on `LIVERELOAD_PORT`, default `35729`). See the README for the `make preview` / `make docker-serve SITE=…` equivalents.

Prefer a local Jekyll build? Install with Ruby instead:

```bash
bundle install
bundle exec jekyll serve
```

Either way, open <http://localhost:4000>. See the [Jekyll theme]({{ '/usage/theme/' | relative_url }}) page for installation details and configuration.

## What you get

- A fixed navbar with your logo and title, dropdown navigation, and a search box.
- A sticky "On this page" sidebar on each page (turns into a drawer on mobile).
- Light/dark mode with a toggle, monochrome palette in both.
- Rouge-highlighted code blocks with opt-in line numbers.

## Next steps

- [Configuration]({{ '/configuration/' | relative_url }}): navigation, footer, search, and front matter.
- [Markdown components]({{ '/markdown/' | relative_url }}): everything you can write in Markdown.
- [HTML components]({{ '/html/' | relative_url }}): everything you can write as raw HTML.