#!/usr/bin/env bash
# Serve a docs-tabler-theme docs site via the published Docker image.
#
# Mounts $SITE (default: current directory) into the container, which builds
# and live-serves it at http://localhost:$PORT. The container uses the
# docs-tabler-theme gem baked into the image, so the folder only needs the
# markdown content (+ optional _nav/ and _footer/).
#
# Usage:
#   ./preview.sh                      # serve $PWD
#   SITE=/path/to/docs ./preview.sh   # serve a specific folder
#   THEME=dark ./preview.sh           # fixed dark mode (both/light/dark)
#   PORT=8080 ./preview.sh            # serve on another port
#   LIVERELOAD_PORT=35729 ./preview.sh  # live reload on another port
set -euo pipefail

SITE="${SITE:-$PWD}"
THEME="${THEME:-both}"
PORT="${PORT:-4000}"
LIVERELOAD_PORT="${LIVERELOAD_PORT:-35729}"
TITLE="${TITLE:-Docs}"
IMAGE="${IMAGE:-ghcr.io/lucasmenendez/docs-tabler-theme:latest}"

if [ ! -d "$SITE" ]; then
  echo "error: not a directory: $SITE" >&2
  exit 1
fi

if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
  echo "==> Pulling $IMAGE"
  docker pull "$IMAGE"
fi

echo "==> Serving $SITE at http://localhost:${PORT} (Ctrl-C to stop)"
docker run \
  --rm \
  -p "${PORT}:4000" \
  -p "${LIVERELOAD_PORT}:35729" \
  -e "TITLE=$TITLE" \
  -e "THEME=$THEME" \
  -e "LIVERELOAD_PORT=$LIVERELOAD_PORT" \
  -v "$SITE:/site" \
  "$IMAGE"