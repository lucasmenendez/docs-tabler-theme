#!/usr/bin/env bash
# Docker container entrypoint: build and serve a Jekyll docs site from the
# /site mount using the docs-tabler-theme gem baked into the image.
#
# The mounted folder holds pure content (markdown + _nav/ + _footer/) — the
# Jekyll scaffold (Gemfile, _config.yml, search.json) is generated on the fly
# into a temp workspace so the source folder is never modified.
#
# Environment:
#   SITE      path to the mounted content folder            [/site]
#   PORT      Jekyll serve port                             [4000]
#   TITLE     site title shown in the navbar                [Docs]
set -euo pipefail

SITE="${SITE:-/site}"
PORT="${PORT:-4000}"
TITLE="${TITLE:-Docs}"

if [ ! -d "$SITE" ]; then
  echo "::error::content folder not found: $SITE (mount it with -v \$PWD:/site)" >&2
  exit 1
fi

WORK="$(mktemp -d)/work"
mkdir -p "$WORK"
cp -R "$SITE"/. "$WORK"/

cat > "$WORK/Gemfile" <<EOF
source "https://rubygems.org"
gem "jekyll", "~> 4.3"
gem "docs-tabler-theme", path: "/theme"
EOF

cat > "$WORK/_config.yml" <<EOF
title: $TITLE
theme: docs-tabler-theme

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
      nav_level: 1
      nav_order: 100
  - scope:
      path: ""
      type: "pages"
    values:
      nav_order: 100
EOF

if [ ! -f "$WORK/search.json" ]; then
  printf -- '---\nlayout: search\n---\n' > "$WORK/search.json"
fi

cd "$WORK"
bundle install --quiet
echo "==> Serving $SITE at http://localhost:${PORT}"
exec bundle exec jekyll serve \
  --host 0.0.0.0 \
  --port "$PORT" \
  --livereload