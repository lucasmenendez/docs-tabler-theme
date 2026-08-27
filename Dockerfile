FROM ruby:3.1-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /theme
COPY _config.yml LICENSE README.md docs-tabler-theme.gemspec ./
COPY _layouts/ _layouts/
COPY _includes/ _includes/
COPY assets/ assets/
RUN gem build docs-tabler-theme.gemspec \
  && gem install ./docs-tabler-theme-*.gem \
  && gem install jekyll --version "~> 4.3"

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /site
EXPOSE 4000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]