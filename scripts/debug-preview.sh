#!/usr/bin/env bash
# Serve the docs-tabler-theme docs site locally.
#
# The docs/ folder holds pure content (markdown + _nav/ + _footer/) — the
# Jekyll scaffold (Gemfile, _config.yml, search.json) is generated on the fly
# into a gitignored .preview/ workspace, so docs/ never gains build files.
# Edits to docs/*.md require re-running this script (source changes don't
# trigger a rebuild, since Jekyll watches the preview copy).
#
# Usage:
#   ./debug-preview.sh            # bundle install (if needed) then jekyll serve
#   ./debug-preview.sh --no-watch # build once without auto-regeneration
#   ./debug-preview.sh --clean    # rm -rf .preview before serving
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."
DOCS_DIR="$REPO_ROOT/docs"
PREVIEW_DIR="$REPO_ROOT/.preview"
PORT="${PORT:-4000}"

ARGS=()
for arg in "$@"; do
  case "$arg" in
    --clean) rm -rf "$PREVIEW_DIR" ;;
    --no-watch) ARGS+=(--no-watch) ;;
    *) ARGS+=("$arg") ;;
  esac
done

# This repo was tested with system Ruby 2.6 (macOS). Jekyll 4.x needs bundler
# >= 2.5 but < 3 on that Ruby, so pin bundler 2.4.22 unless a newer one works.
# Also clear any global $BUNDLER_VERSION pin that forces the wrong bundler.
unset BUNDLER_VERSION
BUNDLER_PIN=""
if ruby -e 'exit(RUBY_VERSION.to_f < 3.0 ? 0 : 1)' 2>/dev/null; then
  BUNDLER_PIN="_2.4.22_"
fi

# Ensure user-installed gems (from `gem install bundler --user-install`) are on PATH.
GEM_USER_BIN="$(ruby -e 'puts Gem.user_dir' 2>/dev/null)/bin"
if [ -n "$GEM_USER_BIN" ] && [ -d "$GEM_USER_BIN" ] && [[ ":$PATH:" != *":$GEM_USER_BIN:"* ]]; then
  export PATH="$GEM_USER_BIN:$PATH"
fi
export GEM_HOME="${GEM_HOME:-$(ruby -e 'puts Gem.user_dir' 2>/dev/null)}"

# Build the preview workspace: fresh content copy + generated Jekyll scaffold.
rm -rf "$PREVIEW_DIR"
mkdir -p "$PREVIEW_DIR"
cp -R "$DOCS_DIR"/. "$PREVIEW_DIR"/

cat > "$PREVIEW_DIR/Gemfile" <<EOF
source "https://rubygems.org"
gem "jekyll", "~> 4.3"
gem "docs-tabler-theme", path: "$REPO_ROOT"
EOF

cat > "$PREVIEW_DIR/_config.yml" <<EOF
title: Docs Tabler
description: Docs Tabler Theme — a Jekyll documentation theme built on Tabler, with a GitHub Action for Pages deployment.
logo: /assets/images/logo.svg
logo_dark: /assets/images/logo-dark.svg
favicon: /assets/images/logo.svg
theme: docs-tabler-theme
theme_mode: both

collections:
  nav:
    output: false
  footer:
    output: false

defaults:
  - scope:
      path: ""
      type: "nav"
    values:
      level: 1
      nav_order: 100
EOF

if [ ! -f "$PREVIEW_DIR/search.json" ]; then
  printf -- '---\nlayout: search\n---\n' > "$PREVIEW_DIR/search.json"
fi

cd "$PREVIEW_DIR"

if ! bundle check >/dev/null 2>&1; then
  echo "==> Installing gems (bundle install)…"
  bundle $BUNDLER_PIN install
fi

echo "==> Serving docs (preview copy at .preview/) at http://localhost:${PORT} (Ctrl-C to stop)"
echo "    Note: edits to docs/*.md require re-running ./debug-preview.sh"
exec bundle $BUNDLER_PIN exec jekyll serve --livereload --port "$PORT" "${ARGS[@]+"${ARGS[@]}"}"