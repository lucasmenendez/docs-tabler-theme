#!/usr/bin/env bash
# Docker container entrypoint: build and serve a Jekyll docs site from the
# /site mount using the docs-tabler-theme gem baked into the image.
#
# The mounted folder holds pure content (markdown + _nav/ + _footer/); the
# Jekyll scaffold (Gemfile, _config.yml, search.json) is generated on the fly
# into a temp workspace so the source folder is never modified.
#
# Environment:
#   SITE              path to the mounted content folder        [/site]
#   PORT              Jekyll serve port                         [4000]
#   LIVERELOAD_PORT   live reload websocket port                [35729]
#   TITLE             site title shown in the navbar            [Docs]
set -euo pipefail

SITE="${SITE:-/site}"
PORT="${PORT:-4000}"
LIVERELOAD_PORT="${LIVERELOAD_PORT:-35729}"
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

# Use the lockfile baked into the image so bundler resolves the exact
# preinstalled gems offline (no network, no compilation).
if [ -f /theme/Gemfile.lock ]; then
  cp /theme/Gemfile.lock "$WORK/Gemfile.lock"
fi

bundle install --quiet

# Mirror the mounted content folder into the Jekyll workspace so edits to the
# real files reach Jekyll (which watches this temp copy, not the mount) and
# trigger live reload. Polling avoids relying on inotify over bind mounts,
# which is unreliable on macOS Docker Desktop. The generated scaffold files
# are excluded so they are never clobbered or deleted.
(
  while true; do
    rsync -a --delete \
      --exclude=Gemfile --exclude=Gemfile.lock \
      --exclude=_config.yml --exclude=search.json \
      --exclude=_site --exclude=.jekyll-cache --exclude=.bundle \
      "$SITE"/ "$WORK"/ || true
sleep 1
    done
  ) &

echo "==> Serving $SITE at http://localhost:${PORT}"
exec bundle exec jekyll serve \
  --host 0.0.0.0 \
  --port "$PORT" \
  --livereload \
  --livereload-port "$LIVERELOAD_PORT"