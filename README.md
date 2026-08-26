# docs-tabler-theme

A [Jekyll](https://jekyllrb.com) documentation theme built on [Tabler](https://tabler.io) v1.4, with a fixed responsive navbar, dropdown navigation, site search, a sticky table of contents, dark mode, and syntax-highlighted code blocks.

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

To preview the theme's own `docs/` content locally, `serve.sh` generates the Jekyll scaffold into a gitignored `.preview/` copy:

```bash
./serve.sh             # build/serve from .preview/
./serve.sh --no-watch  # build once without auto-regeneration
./serve.sh --clean     # wipe .preview before serving
```

Since Jekyll serves the `.preview/` copy, edits to `docs/*.md` require re-running `./serve.sh`.

## License

Copyright (C) 2025 docs-tabler-theme contributors.

This project (including its documentation under `docs/`) is licensed under the **GNU Affero General Public License v3.0** — see [`LICENSE`](LICENSE).

The bundled front-end assets keep their own licenses: Tabler (MIT), Simple-Jekyll-Search (MIT), and Feather Icons (MIT), with their copyright notices preserved in the vendored files. Jekyll (MIT) and Rouge (BSD-2-Clause) are pulled in as runtime dependencies.