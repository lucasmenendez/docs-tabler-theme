#!/usr/bin/env bash
# Build a Jekyll site from a bare markdown content folder using
# docs-tabler-theme, then emit the built site to OUTPUT_PATH.
#
# Environment (set by action.yml or manually for local testing):
#   CONTENT_PATH      folder with the markdown content (recursive + _nav/)   [.]
#   OUTPUT_PATH       where the built site is written, rel. to repo root     [_site]
#   SITE_TITLE        navbar/title text                                       [Docs]
#   SITE_DESCRIPTION  meta description
#   SITE_LOGO         logo path relative to the built site root
#   SITE_LOGO_DARK    dark-mode logo path relative to the built site root
#   THEME             color theme mode: both (toggle), light, or dark         [both]
#   SITE_BASEURL      base URL (e.g. /repo-name for project pages)
#   THEME_PATH        local path to the theme gem (testing; else TEMP/theme)
#   JEKYLL_VERSION    Jekyll version constraint                               [~> 4.3]
#   EXTRA_CONFIG      optional extra Jekyll config file (rel. to repo root) to merge
#   STATIC_PATH       static content to copy verbatim into the built site (single file or folder)
#   STATIC_DEST       target folder inside the built site; a single file keeps its
#                     basename, a folder's contents are copied in (required with STATIC_PATH)
#   JEKYLL_TRACE      pass --trace to jekyll                                  [false]
#   GITHUB_WORKSPACE  repo root on a runner                                   [pwd]
#   RUNNER_TEMP       scratch space on a runner                               [mktemp]
#   GITHUB_OUTPUT     file to append outputs to (runner only)
set -euo pipefail

# Any stale bundler pin from the host must not force a specific version.
unset BUNDLER_VERSION 2>/dev/null || true

# Ensure user-installed gems (e.g. bundler) are on PATH; harmless on runners.
GEM_USER_BIN="$(ruby -e 'puts Gem.user_dir' 2>/dev/null)/bin"
if [ -n "$GEM_USER_BIN" ] && [ -d "$GEM_USER_BIN" ] && [[ ":$PATH:" != *":$GEM_USER_BIN:"* ]]; then
  export PATH="$GEM_USER_BIN:$PATH"
fi

WORKSPACE="${GITHUB_WORKSPACE:-$(pwd)}"
CONTENT_PATH="${CONTENT_PATH:-.}"
OUTPUT_PATH="${OUTPUT_PATH:-_site}"
SITE_TITLE="${SITE_TITLE:-Docs}"
SITE_DESCRIPTION="${SITE_DESCRIPTION:-}"
SITE_LOGO="${SITE_LOGO:-}"
SITE_LOGO_DARK="${SITE_LOGO_DARK:-}"
SITE_FAVICON="${SITE_FAVICON:-}"
THEME="${THEME:-both}"
SITE_BASEURL="${SITE_BASEURL:-}"
THEME_PATH="${THEME_PATH:-}"
JEKYLL_VERSION="${JEKYLL_VERSION:-~> 4.3}"
EXTRA_CONFIG="${EXTRA_CONFIG:-}"
STATIC_PATH="${STATIC_PATH:-}"
STATIC_DEST="${STATIC_DEST:-}"
JEKYLL_TRACE="${JEKYLL_TRACE:-false}"

case "$THEME" in
  both|light|dark) ;;
  *) echo "::error::theme must be one of: both, light, dark (got: $THEME)" >&2; exit 1 ;;
esac

SRC="$(mktemp -d)/src"
OUT="$(mktemp -d)/out"
mkdir -p "$SRC" "$OUT"

# Resolve content folder to an absolute path.
if [[ "$CONTENT_PATH" == /* ]]; then
  CONTENT_ABS="$CONTENT_PATH"
else
  CONTENT_ABS="$WORKSPACE/$CONTENT_PATH"
fi
if [ ! -d "$CONTENT_ABS" ]; then
  echo "::error::content-path not found: $CONTENT_ABS" >&2
  exit 1
fi

# Resolve the theme location.
if [ -n "$THEME_PATH" ]; then
  [[ "$THEME_PATH" == /* ]] && THEME_ABS="$THEME_PATH" || THEME_ABS="$WORKSPACE/$THEME_PATH"
else
  THEME_ABS="${RUNNER_TEMP:-}/theme"
fi
if [ ! -d "$THEME_ABS" ]; then
  echo "::error::theme not found at $THEME_ABS (set theme-path or ensure the theme repo was checked out)" >&2
  exit 1
fi

echo "==> Copying content from $CONTENT_ABS"
rsync -a \
  --exclude "$OUTPUT_PATH" \
  --exclude ".git" \
  --exclude ".github" \
  --exclude ".jekyll-cache" \
  --exclude ".bundle" \
  --exclude "vendor" \
  --exclude "Gemfile" \
  --exclude "Gemfile.lock" \
  "$CONTENT_ABS"/ "$SRC"/

# Generated Jekyll config (theme defaults come from the gem's own _config.yml;
# this file only adds site-level values and can be overridden by EXTRA_CONFIG).
CONFIG_THEME="$SRC/_config.theme.yml"
cat > "$CONFIG_THEME" <<EOF
title: $SITE_TITLE
theme: docs-tabler-theme
theme_mode: $THEME
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
if [ -n "$SITE_DESCRIPTION" ]; then
  echo "description: $SITE_DESCRIPTION" >> "$CONFIG_THEME"
fi
if [ -n "$SITE_LOGO" ]; then
  echo "logo: $SITE_LOGO" >> "$CONFIG_THEME"
fi
if [ -n "$SITE_LOGO_DARK" ]; then
  echo "logo_dark: $SITE_LOGO_DARK" >> "$CONFIG_THEME"
fi
if [ -n "$SITE_FAVICON" ]; then
  echo "favicon: $SITE_FAVICON" >> "$CONFIG_THEME"
fi
if [ -n "$SITE_BASEURL" ]; then
  echo "baseurl: $SITE_BASEURL" >> "$CONFIG_THEME"
fi

# Search index page required by the theme's navbar search.
if [ ! -f "$SRC/search.json" ]; then
  printf -- '---\nlayout: search\n---\n' > "$SRC/search.json"
  echo "==> Created search.json"
fi

# Gemfile referencing the theme by path (no reliance on the Pages whitelist).
cat > "$SRC/Gemfile" <<EOF
source "https://rubygems.org"
gem "jekyll", "$JEKYLL_VERSION"
gem "docs-tabler-theme", path: "$THEME_ABS"
EOF

# Config merge: generated theme config first, then the user's _config.yml (if
# present inside the content), then the explicit EXTRA_CONFIG input. Later
# files override earlier ones in Jekyll's --config merge.
CONFIG_FILES=("$CONFIG_THEME")
if [ -f "$SRC/_config.yml" ]; then
  CONFIG_FILES+=("$SRC/_config.yml")
  echo "==> Merging content _config.yml"
fi
if [ -n "$EXTRA_CONFIG" ]; then
  EXTRA_ABS="$WORKSPACE/$EXTRA_CONFIG"
  if [ ! -f "$EXTRA_ABS" ]; then
    echo "::error::extra config not found: $EXTRA_ABS" >&2
    exit 1
  fi
  cp "$EXTRA_ABS" "$SRC/_config.extra.yml"
  CONFIG_FILES+=("$SRC/_config.extra.yml")
  echo "==> Merging extra config $EXTRA_CONFIG"
fi
CONFIG_ARG="$(IFS=,; echo "${CONFIG_FILES[*]}")"

echo "==> Installing gems"
(
  cd "$SRC"
  bundle config set --local path "$(pwd)/.bundle"
  bundle ${BUNDLER_PIN:-} install --quiet
)

echo "==> Building Jekyll site (baseurl: ${SITE_BASEURL:-none})"
TRACE_FLAG=""
if [ "$JEKYLL_TRACE" = "true" ]; then
  TRACE_FLAG="--trace"
fi
(
  cd "$SRC"
  JEKYLL_ENV=production bundle exec jekyll build \
    --source "$SRC" \
    --destination "$OUT" \
    --config "$CONFIG_ARG" \
    $TRACE_FLAG
)

echo "==> Copying static content (static-path → $OUT/$STATIC_DEST)"
if [ -n "$STATIC_PATH" ]; then
  if [ -z "$STATIC_DEST" ]; then
    echo "::error::static-dest is required when static-path is set" >&2
    exit 1
  fi
  if [[ "$STATIC_PATH" == /* ]]; then
    STATIC_ABS="$STATIC_PATH"
  else
    STATIC_ABS="$WORKSPACE/$STATIC_PATH"
  fi
  if [ -f "$STATIC_ABS" ]; then
    mkdir -p "$OUT/$STATIC_DEST"
    cp "$STATIC_ABS" "$OUT/$STATIC_DEST/$(basename "$STATIC_ABS")"
  elif [ -d "$STATIC_ABS" ]; then
    mkdir -p "$OUT/$STATIC_DEST"
    rsync -a "$STATIC_ABS"/ "$OUT/$STATIC_DEST"/
  else
    echo "::error::static-path not found: $STATIC_ABS" >&2
    exit 1
  fi
fi

echo "==> Writing built site to $WORKSPACE/$OUTPUT_PATH"
rm -rf "$WORKSPACE/$OUTPUT_PATH"
mkdir -p "$WORKSPACE/$OUTPUT_PATH"
rsync -a "$OUT"/ "$WORKSPACE/$OUTPUT_PATH"/

if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "build-path=$WORKSPACE/$OUTPUT_PATH" >> "$GITHUB_OUTPUT"
fi
echo "==> Done. Built site at $WORKSPACE/$OUTPUT_PATH"