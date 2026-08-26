---
title: Configuration
layout: default
permalink: /configuration/
nav_title: Configuration
nav_level: 2
nav_parent: Docs
nav_order: 3
nav_icon: settings
---

# Configuration

Navigation, footer, and search are all configured with front matter and simple files, no plugins needed.

## Navigation

Navbar items come from two sources, merged and sorted by `nav_order`. Both sources use the same `nav_*` field names:

1. **Content pages that opt in**, where you set `nav_level` in the page's front matter and the page appears in the navbar, linking to its own permalink. No `_nav` file needed.
2. **`_nav/*.md` custom links**, for entries that don't correspond to a page (external URLs, grouping parents).

{: .note }
> The navbar is left-aligned. When the brand, links, and search don't all fit on one row, the collapse wraps onto a second row instead of overlapping, so it stays correct for any number of items or a wide logo. Below the `md` breakpoint (768px) it collapses to the hamburger menu.

### Pages defining their own nav entry

```markdown
---
title: HTML components
layout: default
permalink: /html/
nav_title: HTML
nav_level: 2
nav_parent: Docs
nav_order: 2
nav_icon: code
---
```

| Field        | Required | Description |
| ------------ | -------- | ----------- |
| `nav_title`  | no       | Label shown in the navbar (defaults to the page's `title`). |
| `nav_level`  | yes      | `1` = top-level navbar item, `2` = dropdown item under a level-1 item. |
| `nav_parent` | level 2  | `title`/`nav_title` of the level-1 item this nests under. |
| `nav_order`  | no       | Sorting within the same level (defaults to `100`). |
| `nav_icon`   | no       | [Feather icon](https://feathericons.com) name shown before the label. |

{: .note }
> The link target is always the page's own permalink, so there is no `nav_href` on content pages. To point a nav entry elsewhere, use a `_nav/*.md` file.

### `_nav/*.md` custom links

Use these for entries that aren't a page, like external links and grouping parents. One Markdown file per item. The fields share the same `nav_*` names as content pages:

```markdown
---
nav_title: Docs
nav_level: 1
nav_order: 2
---
```

| Field          | Required | Description |
| -------------- | -------- | ----------- |
| `nav_title`    | yes      | Link label. |
| `nav_href`     | no       | Internal path (the theme applies `relative_url`) or a full external URL. **Omit it to render the item as a plain `<span>`**, for example a dropdown parent with no page of its own. |
| `nav_icon`     | no       | [Feather icon](https://feathericons.com) name shown before the label. If omitted, the theme falls back to the linked page's `nav_icon`. External links with no icon get a small `external-link` indicator. |
| `nav_collapsed`| no       | `true` hides the label in the expanded navbar (md+), leaving only the icon; the label shows again in the mobile collapsed menu. The `nav_title` is used as the accessible name. |
| `nav_level`    | yes      | `1` = top-level navbar item, `2` = dropdown item. |
| `nav_parent`   | level 2  | `nav_title` of the level-1 item this nests under. |
| `nav_order`    | no       | Sorting within the same level. |
| `nav_external` | no       | `true` renders `target="_blank"` plus an external-link indicator. |

A level-1 item with children but no link renders as a `<span class="nav-link dropdown-toggle">` that still opens the dropdown.

## Footer

Footer text and links can be defined in `_footer/footer.md` (a `footer` collection with `output: false`, so it is readable but never rendered as a page):

```markdown
---
text: My Docs
links:
  - title: Home
    url: /
    icon: home
  - title: GitHub
    url: https://github.com/username
    external: true
---
```

Each link supports an optional `icon:` shown before the label. External links with no `icon:` get a small `external-link` indicator. Set `search: false` in the front matter to keep it out of the search index.

If `_footer/footer.md` is absent, the theme falls back to the `footer:` block in `_config.yml`:

```yaml
footer:
  text: My Docs
  links:
    - title: Home
      url: /
```

## Search index

Create a `search.json` page in your site:

```markdown
---
layout: search
---
```

The `search` layout emits a JSON index over `site.pages` and `site.posts`. The navbar search form queries it client-side. When using the GitHub Action, this file is generated automatically if missing.

## Page front matter

- Layouts: `home` (index), `default`, `page`.
- Set `toc: false` on a page to hide its right sidebar.
- Set `nav_level: 1|2` (plus optional `nav_title`, `nav_parent`, `nav_order`, `nav_icon`) to place the page in the navbar.