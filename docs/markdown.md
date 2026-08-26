---
title: Markdown components
layout: default
permalink: /markdown/
nav_title: Markdown components
nav_level: 2
nav_parent: Docs
nav_order: 4
nav_icon: file-text
---

# Markdown components

Everything below is written with plain Markdown, no plugins. Each component shows a short description, the source you write, and the rendered result. For components that need raw HTML, see the [HTML components]({{ '/html/' | relative_url }}) page.

## Typography

### Headings

Write headings with `#` through `######`. The theme styles them and the "On this page" sidebar is generated from `h2`/`h3`/`h4` headings with an `id`.

**Source:**

```markdown
## Heading level 2
### Heading level 3
#### Heading level 4
```

**Result:**

### Heading level 2

#### Heading level 3

##### Heading level 4

### Lead text

A `.lead` paragraph right after a page title summarizes the page:

```markdown
<p class="lead">A short summary of the page.</p>
```

<p class="lead">A short summary of the page. Lead text is larger and lighter than body text.</p>

### Inline text elements

**Source:**

```markdown
You can use **bold**, *italic*, ***bold italic***, ~~strikethrough~~, and `inline code`.
Markups also include <mark>highlighted text</mark>, <u>underlined</u>, <small>small print</small>,
H<sub>2</sub>O for subscripts, and x<sup>2</sup> for superscripts.
```

**Result:**

You can use **bold**, *italic*, ***bold italic***, ~~strikethrough~~, and `inline code`. Markups also include <mark>highlighted text</mark>, <u>underlined</u>, <small>small print</small>, H<sub>2</sub>O for subscripts, and x<sup>2</sup> for superscripts.

### Links

**Source:**

```markdown
- Internal link: [Markdown components]({{ '/markdown/' | relative_url }})
- Internal with anchor: [Callouts](#callouts)
- External link: [Example.com](https://example.com)
- Mail link: [hello@example.com](mailto:hello@example.com)
```

**Result:**

- Internal link: [HTML components]({{ '/html/' | relative_url }})
- Internal with anchor: [Callouts](#callouts)
- External link: [Example.com](https://example.com)
- Mail link: [hello@example.com](mailto:hello@example.com)

{: .note }
> Internal links **must** use the Jekyll filters `relative_url` or `absolute_url`, since raw relative paths break the deployed site.

## Button links

Turn any Markdown link into a button with a kramdown inline attribute list (IAL) of Tabler button classes:

```markdown
[Primary](https://example.com){: .btn .btn-primary }
[Outline](https://example.com){: .btn .btn-outline-secondary }
[New tab](https://example.com){: .btn .btn-info target="_blank" }
```

<div class="d-flex flex-wrap gap-2">
  <a href="https://example.com" class="btn btn-primary">Primary</a>
  <a href="https://example.com" class="btn btn-outline-secondary">Outline</a>
  <a href="https://example.com" class="btn btn-info" target="_blank" rel="noopener">New tab</a>
</div>

All Tabler `.btn` variants work, including colors, outlines, `btn-sm`/`btn-lg`, and `btn-link`, and HTML attributes like `target="_blank"` can be added.

### Buttons with icons

Add a Feather icon with the `data-feather="name"` IAL attribute, which renders it before the label:

```markdown
[Download](https://example.com){: .btn .btn-primary data-feather="download" }
[Submit](https://example.com){: .btn .btn-success data-feather="send" }
```

<div class="d-flex flex-wrap gap-2">
  <a href="https://example.com" class="btn btn-primary"><i data-feather="download" aria-hidden="true"></i> Download</a>
  <a href="https://example.com" class="btn btn-success"><i data-feather="send" aria-hidden="true"></i> Submit</a>
</div>

{: .note }
> The `data-feather` IAL attribute only works on buttons. To place an icon anywhere else in your content, see [Feather icons]({{ '/html/' | relative_url }}) on the HTML components page.

## Callouts

The theme styles documentation callouts, which are a blockquote with an inline attribute list. Five variants:

```markdown
{: .info }
> `.info`: neutral information.

{: .note }
> `.note`: key detail.

{: .success }
> `.success`: everything worked.

{: .warning }
> `.warning`: heads up.

{: .danger }
> `.danger`: action required.
```

{: .info }
> `.info`: neutral information. Use it for neutral context.

{: .note }
> `.note`: key detail the reader shouldn't miss.

{: .success }
> `.success`: everything worked as expected.

{: .warning }
> `.warning`: something needs attention.

{: .danger }
> `.danger`: action required before continuing.

## Blockquotes

**Source:**

```markdown
> A blockquote pulls a short quotation out of the surrounding text.
```

**Result:**

> A blockquote pulls a short quotation out of the surrounding text with a left border and muted color.

You can nest blockquotes:

```markdown
> First level
>
> > Second level
>
> > > Third level
```

> First level
>
> > Second level
> >
> > > Third level

## Lists

### Unordered list

**Source:**

```markdown
- Lorem ipsum dolor sit amet
- Consectetur adipiscing elit
  - Nested item
- Sed do eiusmod tempor
```

**Result:**

- Lorem ipsum dolor sit amet
- Consectetur adipiscing elit
  - Nested item
- Sed do eiusmod tempor

### Ordered list

**Source:**

```markdown
1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Sed do eiusmod tempor
```

**Result:**

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Sed do eiusmod tempor

### Task list

**Source:**

```markdown
- [x] Navbar with dropdowns
- [x] Sticky table of contents
- [ ] Dark mode polish
```

**Result:**

- [x] Navbar with dropdowns
- [x] Sticky table of contents
- [ ] Dark mode polish

## Tables

**Source:**

```markdown
| Feature      | Supported | Notes                            |
| ------------ | :-------: | -------------------------------- |
| Headings     |    ✅     | Auto-generated `id` for anchors  |
| Buttons      |    ✅     | See [Button links](#button-links)|
| Code blocks  |    ✅     | Rouge syntax highlighting        |
```

**Result:**

| Feature      | Supported | Notes                              |
| ------------ | :-------: | ---------------------------------- |
| Headings     |    ✅     | Auto-generated `id` for anchors    |
| Buttons      |    ✅     | See [Button links](#button-links)  |
| Code blocks  |    ✅     | Rouge syntax highlighting          |

Tables support column alignment, header styling, and long content wrapping:

```markdown
| Item  | Quantity | Unit price | Notes |
| ----- | -------: | ---------: | ----- |
| Alpha | 2        |      10.00 | In stock |
| Beta  | 1        |      25.50 | Low stock |
```

| Item  | Quantity | Unit price | Notes     |
| ----- | -------: | ---------: | --------- |
| Alpha | 2        |      10.00 | In stock  |
| Beta  | 1        |      25.50 | Low stock |

## Code blocks

### Inline code

**Source:**

```markdown
Use `code` for inline snippets like `npm install` or `api_key`.
```

**Result:**

Use `code` for inline snippets like `npm install` or `api_key`.

### Fenced code blocks

Fenced blocks get Rouge highlighting with theme token colors, always on a dark background:

````markdown
```go
func main() {
	fmt.Println("hello world")
}
```
````

```go
func main() {
	fmt.Println("hello world")
}
```

### Line numbers

Opt in per block with the Jekyll tag:

{% raw %}
```liquid
{% highlight go linenos %}
func main() {
	fmt.Println("hello world")
}
{% endhighlight %}
```
{% endraw %}

{% highlight go linenos %}
func main() {
	fmt.Println("hello world")
}
{% endhighlight %}

{: .note }
> Wrap the tag itself in `{% raw %}…{% endraw %}` when documenting it, as above, so Liquid doesn't execute it.

## Images

Images are responsive and centered with their alt text:

**Source:**

```markdown
![Docs logo]({{ '/assets/images/logo.svg' | relative_url }})
```

**Result:**

![Docs logo]({{ '/assets/images/logo.svg' | relative_url }})

A smaller image with a caption:

```markdown
<figure class="figure">
  <img src="{{ '/assets/images/logo.svg' | relative_url }}" class="figure-img img-fluid rounded" alt="Docs logo" width="96">
  <figcaption class="figure-caption">A caption below the image.</figcaption>
</figure>
```

<figure class="figure">
  <img src="{{ '/assets/images/logo.svg' | relative_url }}" class="figure-img img-fluid rounded" alt="Docs logo" width="96">
  <figcaption class="figure-caption">A caption below the image.</figcaption>
</figure>

## Horizontal rules

**Source:**

```markdown
A paragraph before the rule.

---

A paragraph after the rule.
```

**Result:**

A paragraph before the rule.

---

A paragraph after the rule.

## Footnotes

**Source:**

```markdown
Here is a sentence with a footnote.[^1]

[^1]: Footnotes render at the bottom of the page with backlinks.
```

**Result:**

Here is a sentence with a footnote.[^1]

[^1]: Footnotes render at the bottom of the page with backlinks. This is footnote number one.

## Conclusion

That covers the Markdown components. Check the [HTML components]({{ '/html/' | relative_url }}) page for cards, forms, tabs, and other components written as raw HTML.