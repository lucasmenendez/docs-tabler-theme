FROM ruby:3.1-alpine AS builder

RUN apk add --no-cache build-base openssl-dev ca-certificates

WORKDIR /theme
COPY _config.yml LICENSE README.md docs-tabler-theme.gemspec ./
COPY _layouts/ _layouts/
COPY _includes/ _includes/
COPY assets/ assets/

# Gemfile must match the one scripts/entrypoint.sh generates so the baked
# Gemfile.lock stays in sync with the runtime bundle.
RUN printf 'source "https://rubygems.org"\ngem "jekyll", "~> 4.3"\ngem "docs-tabler-theme", path: "/theme"\n' > Gemfile \
  && gem build docs-tabler-theme.gemspec \
  && gem install --no-document ./docs-tabler-theme-*.gem \
  && bundle install --quiet \
  && bundle lock --add-platform aarch64-linux-musl --add-platform x86_64-linux-musl

FROM ruby:3.1-alpine

RUN apk add --no-cache bash ca-certificates libstdc++ rsync

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /theme /theme
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /site
EXPOSE 4000
EXPOSE 35729
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]