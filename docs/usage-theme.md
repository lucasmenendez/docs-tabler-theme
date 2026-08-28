---
title: Use as a Jekyll theme
layout: default
permalink: /docs/usage/theme/
nav_title: Jekyll theme
nav_level: 2
nav_parent: Docs
nav_order: 1
nav_icon: package
---

# Use as a Jekyll theme

Install Docs Tabler Theme as a regular Jekyll gem when you manage your own site and build.

## Installation

Add the theme to your `Gemfile`:

```ruby
gem "docs-tabler-theme", github: "lucasmenendez/docs-tabler-theme"
```

Or reference it from a local checkout:

```ruby
gem "docs-tabler-theme", path: "../theme-tabler"
```

Set it as the active theme in `_config.yml`:

```yaml
theme: docs-tabler-theme
```

Then install and build:

```bash
bundle install
bundle exec jekyll serve
```

## Layouts

Three layouts are provided:

| Layout  | When to use                                                        |
| ------- | ------------------------------------------------------------------ |
| `home`  | The site index, a plain centered page with no TOC sidebar.        |
| `default` | Standard documentation page with the sticky "On this page" sidebar. |
| `page`  | Alias of `default`.                                                |

```markdown
---
layout: default
---
```

Use `home` on your landing page and `default` everywhere else.

## Site configuration

The theme reads these `_config.yml` values:

```yaml
title: My Docs          # navbar brand + <title>
description: ...        # meta description
logo: assets/images/logo.svg        # shown in light mode
logo_dark: assets/images/logo-dark.svg  # shown in dark mode (optional)
favicon: assets/images/favicon.ico   # browser tab icon (optional; defaults to the theme's logo.svg)
```

If `logo_dark` is omitted, `logo` is used in both modes. `favicon` accepts an `.ico`, `.png`, or `.svg` path relative to the site root; omit it to use the theme's bundled logo as the favicon. See [Configuration]({{ '/configuration/' | relative_url }}) for navigation, footer, and search setup.

## Code blocks

Fenced code blocks get Rouge highlighting with theme token colors in both modes:

````markdown
```go
func main() {
	fmt.Println("hello")
}
```
````

{: .note }
> **Note:** the outer fence above uses four backticks so the inner ```go fence renders literally. In your content, write normal triple backticks.

Add line numbers per block with the Jekyll tag:

{% raw %}
```liquid
{% highlight go linenos %}
func main() {
	fmt.Println("hello")
}
{% endhighlight %}
```
{% endraw %}

That covers the gem setup. To deploy without touching Ruby at all, use the [GitHub Action]({{ '/usage/action/' | relative_url }}).