.DEFAULT_GOAL := help
TITLE ?= Docs
.PHONY: help build debug-preview docker-build docker-serve preview clean

help:
	@echo "docs-tabler-theme development targets:"
	@echo "  build          test the action build logic on this repo's own docs/"
	@echo "  debug-preview  live-preview this repo's docs/ with local Jekyll (.preview/)"
	@echo "  docker-build   build the Docker preview image locally"
	@echo "  docker-serve   build + serve a mounted folder via Docker (SITE required)"
	@echo "  preview        serve the current folder via the published Docker image"
	@echo "  clean          remove local build/preview artifacts"

build:
	CONTENT_PATH=docs THEME_PATH=. OUTPUT_PATH=/tmp/pages-out ./scripts/build.sh

debug-preview:
	./scripts/debug-preview.sh

docker-build:
	docker build -t docs-tabler-theme .

docker-serve:
	@test -n "$(SITE)" || (echo "Usage: make docker-serve SITE=/path/to/content" >&2; exit 1)
	docker build -t docs-tabler-theme .
	docker run --rm -p 4000:4000 -p 35729:35729 -e "TITLE=$(TITLE)" -v "$(SITE):/site" docs-tabler-theme

preview:
	./scripts/preview.sh

clean:
	rm -rf .preview _site .jekyll-cache