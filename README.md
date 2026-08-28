# docs-tabler-theme

A [Jekyll](https://jekyllrb.com) documentation theme built on [Tabler](https://tabler.io) v1.4, with a fixed responsive navbar, dropdown navigation, site search, a sticky table of contents, light/dark theming (toggle or fixed), and syntax-highlighted code blocks.

It also ships as a **composite GitHub Action** that builds a Jekyll site from a bare Markdown folder, so a consuming repo needs no Gemfile, no `_config.yml`, and no Ruby knowledge.

## Documentation

**The full documentation is at <https://lucasmenendez.github.io/docs-tabler-theme>.**

It covers:

- [Getting started](https://lucasmenendez.github.io/docs-tabler-theme/getting-started/)
- [Use as a Jekyll theme](https://lucasmenendez.github.io/docs-tabler-theme/usage/theme/)
- [Use as a GitHub Action](https://lucasmenendez.github.io/docs-tabler-theme/usage/action/)
- [Configuration](https://lucasmenendez.github.io/docs-tabler-theme/configuration/)
- [Markdown components](https://lucasmenendez.github.io/docs-tabler-theme/markdown/)
- [HTML components](https://lucasmenendez.github.io/docs-tabler-theme/html/)

## Development / preview

To preview the theme's own `docs/` content locally, `scripts/debug-preview.sh` generates the Jekyll scaffold into a gitignored `.preview/` copy:

```bash
make debug-preview          # build/serve from .preview/
./scripts/debug-preview.sh  # same, directly
./scripts/debug-preview.sh --no-watch  # build once without auto-regeneration
./scripts/debug-preview.sh --clean     # wipe .preview before serving
```

Since Jekyll serves the `.preview/` copy, edits to `docs/*.md` require re-running the script.

## Docker preview

The repo ships a `ruby:3.1-slim` Docker image (built and published to `ghcr.io/lucasmenendez/docs-tabler-theme` by `.github/workflows/docker.yml`) that builds and live-serves **any** docs-tabler-theme content folder without Ruby installed locally. The folder only needs the markdown content (`_nav/` and `_footer/` are optional); the Jekyll scaffold is generated inside the container.

One-liner: serve the current directory.

```bash
curl -fsSL https://lucasmenendez.github.io/docs-tabler-theme/sh/preview.sh | bash
```

or via the checked-out repo / Makefile:

```bash
./scripts/preview.sh                     # serve $PWD
SITE=/path/to/docs PORT=8080 ./scripts/preview.sh
make preview                             # same as ./scripts/preview.sh
make docker-serve SITE=docs              # build locally + serve a folder (requires SITE)
```

`preview.sh` mounts the folder into the image and serves it at `http://localhost:4000` (overridable with `PORT`) with live reload (overridable with `LIVERELOAD_PORT`, default `35729`). Both ports are published on the host.

## License

Copyright (C) 2025 docs-tabler-theme contributors.

This project (including its documentation under `docs/`) is licensed under the **GNU Affero General Public License v3.0**; see [`LICENSE`](LICENSE).

The bundled front-end assets keep their own licenses: Tabler (MIT), Simple-Jekyll-Search (MIT), and Feather Icons (MIT), with their copyright notices preserved in the vendored files. Jekyll (MIT) and Rouge (BSD-2-Clause) are pulled in as runtime dependencies.