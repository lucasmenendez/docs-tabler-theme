---
title: HTML components
layout: default
permalink: /html/
nav_title: HTML components
nav_level: 2
nav_parent: Docs
nav_order: 5
nav_icon: code
---

# HTML components

Components that need raw HTML are written directly in your content, since kramdown passes inline HTML through untouched. Each component below shows a short description, the source, and the rendered result. For plain Markdown components, see the [Markdown components]({{ '/markdown/' | relative_url }}) page.

## Buttons

Use Tabler button classes on `<button>` or `<a>` elements:

```html
<button type="button" class="btn btn-primary">Primary</button>
<button type="button" class="btn btn-secondary">Secondary</button>
<a href="#" class="btn btn-outline-primary">Outline</a>
```

<div class="d-flex flex-wrap gap-2 my-3">
  <button type="button" class="btn btn-primary">Primary</button>
  <button type="button" class="btn btn-secondary">Secondary</button>
  <button type="button" class="btn btn-success">Success</button>
  <button type="button" class="btn btn-danger">Danger</button>
  <button type="button" class="btn btn-warning">Warning</button>
  <button type="button" class="btn btn-info">Info</button>
  <button type="button" class="btn btn-light">Light</button>
  <button type="button" class="btn btn-dark">Dark</button>
</div>

<div class="d-flex flex-wrap gap-2 my-3">
  <a href="#" class="btn btn-outline-primary">Outline primary</a>
  <a href="#" class="btn btn-outline-secondary">Outline secondary</a>
  <a href="#" class="btn btn-outline-danger">Outline danger</a>
  <a href="#" class="btn btn-link">Link button</a>
</div>

### Sizes and disabled

```html
<button type="button" class="btn btn-primary btn-sm">Small</button>
<button type="button" class="btn btn-primary">Default</button>
<button type="button" class="btn btn-primary btn-lg">Large</button>
<button type="button" class="btn btn-primary" disabled>Disabled</button>
```

<div class="d-flex flex-wrap gap-2 my-3 align-items-center">
  <button type="button" class="btn btn-primary btn-sm">Small</button>
  <button type="button" class="btn btn-primary">Default</button>
  <button type="button" class="btn btn-primary btn-lg">Large</button>
  <button type="button" class="btn btn-primary" disabled>Disabled</button>
</div>

## Badges

```html
<span class="badge bg-primary text-primary-fg">primary</span>
<span class="badge badge-pill bg-secondary text-secondary-fg">pill badge</span>
```

<div class="my-3">
  <span class="badge bg-primary text-primary-fg">primary</span>
  <span class="badge bg-secondary text-secondary-fg">secondary</span>
  <span class="badge bg-success text-success-fg">success</span>
  <span class="badge bg-danger text-danger-fg">danger</span>
  <span class="badge bg-warning text-warning-fg">warning</span>
  <span class="badge bg-info text-info-fg">info</span>
  <span class="badge bg-light text-light-fg">light</span>
  <span class="badge bg-dark text-dark-fg">dark</span>
</div>

Badges can also be used inline in prose, like this <span class="badge bg-info text-info-fg">NEW</span> marker or a <span class="badge badge-pill bg-secondary text-secondary-fg">pill badge</span>.

## Feather icons

[Feather icons](https://feathericons.com) are bundled with the theme. Write a raw `<i>` tag with the icon name in `data-feather`; the theme swaps it for an inline SVG on page load.

```html
Inline in prose: press <i data-feather="send"></i> to submit.
Decorative icon (hidden from screen readers): <i data-feather="github" aria-hidden="true"></i>
```

Inline in prose: press <i data-feather="send"></i> to submit.

Icons inherit the text color (`stroke="currentColor"`) and scale with the font, adapting to light/dark mode automatically. Attributes on the `<i>` are copied onto the generated SVG:

```html
Big icon: <i data-feather="heart" style="width:32px;height:32px" class="text-danger"></i>
Thin stroke: <i data-feather="settings" stroke-width="1"></i>
```

The full icon list is at [feathericons.com](https://feathericons.com). Icons in headings are swapped before the TOC is built, so they never leak into the sidebar. For Feather icons on buttons, see the `data-feather` IAL attribute in [Button links]({{ '/markdown/#buttons-with-icons' | relative_url }}).

## Alerts

```html
<div class="alert alert-primary" role="alert">A primary alert: important information in a box.</div>
<div class="alert alert-success" role="alert"><strong>Success!</strong> Everything worked.</div>
<div class="alert alert-warning" role="alert"><strong>Heads up.</strong> Something needs attention.</div>
<div class="alert alert-danger" role="alert"><strong>Danger zone.</strong> This cannot be undone.</div>
```

<div class="alert alert-primary" role="alert">A primary alert: important information in a box.</div>
<div class="alert alert-success" role="alert"><strong>Success!</strong> Everything worked as expected.</div>
<div class="alert alert-warning" role="alert"><strong>Heads up.</strong> Something needs attention.</div>
<div class="alert alert-danger" role="alert"><strong>Danger zone.</strong> This action cannot be undone.</div>

## Definition list

```html
<dl>
  <dt>Term one</dt>
  <dd>Definition of the first term goes here.</dd>
  <dt>Term two</dt>
  <dd>Definition of the second term goes here.</dd>
</dl>
```

<dl>
  <dt>Term one</dt>
  <dd>Definition of the first term goes here.</dd>
  <dt>Term two</dt>
  <dd>Definition of the second term goes here.</dd>
</dl>

## Cards

```html
<div class="card mb-3">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
```

<div class="card mb-3">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>

### Card groups

```html
<div class="card-group mb-3">
  <div class="card"><div class="card-body"><h6 class="card-title">Feature one</h6><p class="card-text mb-0">Short description.</p></div></div>
  <div class="card"><div class="card-body"><h6 class="card-title">Feature two</h6><p class="card-text mb-0">Short description.</p></div></div>
  <div class="card"><div class="card-body"><h6 class="card-title">Feature three</h6><p class="card-text mb-0">Short description.</p></div></div>
</div>
```

<div class="card-group mb-3">
  <div class="card">
    <div class="card-body">
      <h6 class="card-title">Feature one</h6>
      <p class="card-text mb-0">Short description of the first feature.</p>
    </div>
  </div>
  <div class="card">
    <div class="card-body">
      <h6 class="card-title">Feature two</h6>
      <p class="card-text mb-0">Short description of the second feature.</p>
    </div>
  </div>
  <div class="card">
    <div class="card-body">
      <h6 class="card-title">Feature three</h6>
      <p class="card-text mb-0">Short description of the third feature.</p>
    </div>
  </div>
</div>

## Accordion

```html
<div class="accordion mb-3" id="accordion-demo">
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-one" aria-expanded="true" aria-controls="collapse-one">
        Question one?
      </button>
    </h2>
    <div id="collapse-one" class="accordion-collapse collapse show" data-bs-parent="#accordion-demo">
      <div class="accordion-body">Answer to question one goes here.</div>
    </div>
  </div>
</div>
```

<div class="accordion mb-3" id="accordion-demo">
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-one" aria-expanded="true" aria-controls="collapse-one">
        Question one?
      </button>
    </h2>
    <div id="collapse-one" class="accordion-collapse collapse show" data-bs-parent="#accordion-demo">
      <div class="accordion-body">Answer to question one goes here.</div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse-two" aria-expanded="false" aria-controls="collapse-two">
        Question two?
      </button>
    </h2>
    <div id="collapse-two" class="accordion-collapse collapse" data-bs-parent="#accordion-demo">
      <div class="accordion-body">Answer to question two goes here.</div>
    </div>
  </div>
</div>

## Tabs

```html
<ul class="nav nav-tabs mb-2" id="tabs-demo" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="tab-one-tab" data-bs-toggle="tab" data-bs-target="#tab-one" type="button" role="tab" aria-controls="tab-one" aria-selected="true">Tab one</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="tab-two-tab" data-bs-toggle="tab" data-bs-target="#tab-two" type="button" role="tab" aria-controls="tab-two" aria-selected="false">Tab two</button>
  </li>
</ul>
<div class="tab-content mb-3">
  <div class="tab-pane fade show active" id="tab-one" role="tabpanel" aria-labelledby="tab-one-tab">
    <p>Content for the first tab.</p>
  </div>
  <div class="tab-pane fade" id="tab-two" role="tabpanel" aria-labelledby="tab-two-tab">
    <p>Content for the second tab.</p>
  </div>
</div>
```

<ul class="nav nav-tabs mb-2" id="tabs-demo" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="tab-one-tab" data-bs-toggle="tab" data-bs-target="#tab-one" type="button" role="tab" aria-controls="tab-one" aria-selected="true">Tab one</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="tab-two-tab" data-bs-toggle="tab" data-bs-target="#tab-two" type="button" role="tab" aria-controls="tab-two" aria-selected="false">Tab two</button>
  </li>
</ul>
<div class="tab-content mb-3">
  <div class="tab-pane fade show active" id="tab-one" role="tabpanel" aria-labelledby="tab-one-tab">
    <p>Content for the first tab. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
  </div>
  <div class="tab-pane fade" id="tab-two" role="tabpanel" aria-labelledby="tab-two-tab">
    <p>Content for the second tab. Sed do eiusmod tempor incididunt ut labore.</p>
  </div>
</div>

## Breadcrumb

```html
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">This page</li>
  </ol>
</nav>
```

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="{{ '/' | relative_url }}">Home</a></li>
    <li class="breadcrumb-item"><a href="{{ '/html/' | relative_url }}">HTML components</a></li>
    <li class="breadcrumb-item active" aria-current="page">This page</li>
  </ol>
</nav>

## Progress and spinners

```html
<div class="progress" role="progressbar" aria-label="Progress" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
  <div class="progress-bar" style="width: 75%">75%</div>
</div>
```

<div class="progress mb-3" role="progressbar" aria-label="Progress" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">
  <div class="progress-bar" style="width: 75%">75%</div>
</div>

```html
<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading…</span></div>
<div class="spinner-grow text-success" role="status"><span class="visually-hidden">Loading…</span></div>
```

<div class="d-flex gap-3 align-items-center">
  <div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading…</span></div>
  <div class="spinner-grow text-success" role="status"><span class="visually-hidden">Loading…</span></div>
  <span class="spinner-border spinner-border-sm text-secondary" role="status"><span class="visually-hidden">Loading…</span></span>
</div>

## List group

```html
<ul class="list-group mb-3">
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Items in cart
    <span class="badge badge-pill bg-primary text-primary-fg">14</span>
  </li>
  <li class="list-group-item active" aria-current="true">Active list item</li>
  <li class="list-group-item disabled" aria-disabled="true">Disabled list item</li>
</ul>
```

<ul class="list-group mb-3">
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Items in cart
    <span class="badge badge-pill bg-primary text-primary-fg">14</span>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Orders placed
    <span class="badge badge-pill bg-primary text-primary-fg">312</span>
  </li>
  <li class="list-group-item active" aria-current="true">Active list item</li>
  <li class="list-group-item disabled" aria-disabled="true">Disabled list item</li>
</ul>

## Forms

```html
<form>
  <div class="mb-3">
    <label for="demo-email" class="form-label">Email address</label>
    <input type="email" class="form-control" id="demo-email" placeholder="name@example.com">
  </div>
  <div class="mb-3">
    <label for="demo-select" class="form-label">Choose an option</label>
    <select class="form-select" id="demo-select">
      <option>Option A</option>
      <option selected>Option C</option>
    </select>
  </div>
  <div class="form-check mb-3">
    <input class="form-check-input" type="checkbox" id="demo-check">
    <label class="form-check-label" for="demo-check">Check this option</label>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```

<form class="mb-3">
  <div class="mb-3">
    <label for="demo-email" class="form-label">Email address</label>
    <input type="email" class="form-control" id="demo-email" placeholder="name@example.com">
  </div>
  <div class="mb-3">
    <label for="demo-select" class="form-label">Choose an option</label>
    <select class="form-select" id="demo-select">
      <option>Option A</option>
      <option>Option B</option>
      <option selected>Option C</option>
      <option>Option D</option>
    </select>
  </div>
  <div class="form-check mb-3">
    <input class="form-check-input" type="checkbox" id="demo-check">
    <label class="form-check-label" for="demo-check">Check this option</label>
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>

## Conclusion

That covers the HTML components. Check the [Markdown components]({{ '/markdown/' | relative_url }}) page for typography, buttons, icons, and code blocks written in plain Markdown.