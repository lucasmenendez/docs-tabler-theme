---
layout: home
nav_title: Home
nav_level: 1
nav_order: 1
nav_icon: home
---

<div class="display-4 fw-bold mb-2">Docs Tabler Theme</div>

<p class="lead">A <a href="https://jekyllrb.com">Jekyll</a> documentation theme built on <a href="https://tabler.io">Tabler</a> v1.4, with a fixed responsive navbar, dropdown navigation, site search, a sticky table of contents, and dark mode, all without a build step.</p>

<div class="d-flex flex-wrap gap-2 my-4">
  <a href="{{ '/getting-started/' | relative_url }}" class="btn btn-primary" data-feather="zap">Get started</a>
  <a href="https://github.com/lucasmenendez/docs-tabler-theme" class="btn btn-outline-secondary" data-feather="github">View on GitHub</a>
</div>

Use it two ways: as a [normal Jekyll theme]({{ '/usage/theme/' | relative_url }}) in your Gemfile, or as a [composite GitHub Action]({{ '/usage/action/' | relative_url }}) that builds a site from a bare markdown folder, with no Gemfile and no Ruby knowledge needed.

## Features

<div class="row row-cols-1 row-cols-md-2 g-3 mb-3">
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="layout" aria-hidden="true"></i> Fixed responsive navbar</h6>
        <p class="card-text mb-0">Logo + site title, level-aware navigation links with dropdowns, and a built-in search form.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="search" aria-hidden="true"></i> Client-side search</h6>
        <p class="card-text mb-0">Powered by SimpleJekyllSearch over a generated <code>search.json</code>; vanilla JS and GitHub Pages compatible.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="book-open" aria-hidden="true"></i> Sticky table of contents</h6>
        <p class="card-text mb-0">A sticky "On this page" sidebar generated from your headings, with an accordion and an offcanvas drawer on mobile.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="moon" aria-hidden="true"></i> Dark mode</h6>
        <p class="card-text mb-0">Light and dark schemes out of the box, with a moon/sun toggle and a monochrome palette in both.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="terminal" aria-hidden="true"></i> Code blocks</h6>
        <p class="card-text mb-0">Rouge syntax highlighting with always-dark blocks and opt-in line numbers.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="feather" aria-hidden="true"></i> Feather icons</h6>
        <p class="card-text mb-0">Icons everywhere, in prose, buttons, and the navbar, with a bundled, pinned copy of Feather Icons.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="github" aria-hidden="true"></i> GitHub Action</h6>
        <p class="card-text mb-0">Build and deploy docs on GitHub Pages from a bare markdown folder with a single workflow step.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="card-title"><i data-feather="zap" aria-hidden="true"></i> No build step</h6>
        <p class="card-text mb-0">Tabler's compiled CSS and JS are vendored and pinned, so there is nothing to bundle, compile, or purge.</p>
      </div>
    </div>
  </div>
</div>

## Component reference

Everything you can write is documented on two pages, with a description, the source, and the live result for every component:

- [Markdown components]({{ '/markdown/' | relative_url }}): typography, buttons, icons, callouts, lists, tables, code blocks, and more, written in plain Markdown.
- [HTML components]({{ '/html/' | relative_url }}): cards, badges, alerts, tabs, forms, and other components written as raw HTML.

Browse them to see every style this theme ships with.