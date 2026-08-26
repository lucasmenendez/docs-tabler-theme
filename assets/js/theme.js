---
---
/* docs-tabler-theme — client-side behavior. */
(function () {
  "use strict";

  /* ---------- Table of contents ----------
     Build the right sidebar from h2/h3/h4 headings inside .docs-content as
     an accordion: h2 sections are top-level items, h3/h4 nest under them.
     Only the h2 titles are always visible; a section's children appear when
     its h2 is clicked or when you scroll into it, and stay open until you
     scroll out of the section or click another h2 (only one open at a time).
     Populates the desktop sticky list and the mobile offcanvas. */
  function buildToc() {
    var content = document.querySelector(".docs-content");
    var desktopList = document.getElementById("toc-desktop");
    var mobileList = document.getElementById("toc-mobile");
    var tocCol = document.getElementById("toc-col");
    var mainCol = document.getElementById("main-col");

    if (!content || !desktopList || !tocCol) {
      return;
    }

    var headings = Array.prototype.slice.call(
      content.querySelectorAll("h2[id], h3[id], h4[id]")
    );
    if (headings.length === 0) {
      tocCol.classList.add("d-none");
      if (mainCol) {
        mainCol.classList.remove("col-lg-9", "col-xxl-10");
        mainCol.classList.add("col-lg-12", "col-xxl-12");
      }
      return;
    }

    /* Group headings: h2 starts a new section; h3/h4 nest under the current
       h2. h3/h4 that appear before any h2 are promoted to their own section. */
    var groups = [];
    var current = null;
    headings.forEach(function (heading) {
      var level = heading.tagName.slice(1);
      if (level === "2") {
        current = { heading: heading, children: [] };
        groups.push(current);
      } else if (current) {
        current.children.push(heading);
      } else {
        current = { heading: heading, children: [] };
        groups.push(current);
      }
    });

    /* Materialize the shared group structure into one list container.
       Returns a per-list lookup so handlers never share DOM or ids. */
    function buildList(container) {
      var byId = {};
      var groupEls = [];
      var allLinks = [];

      groups.forEach(function (group) {
        var li = document.createElement("li");
        li.className = "toc-item";

        var a = document.createElement("a");
        a.href = "#" + group.heading.id;
        a.textContent = group.heading.textContent;
        a.classList.add("toc-link", "toc-h2");
        li.appendChild(a);
        allLinks.push(a);
        byId[group.heading.id] = { item: li, link: a };

        if (group.children.length > 0) {
          li.classList.add("has-children");
          var ul = document.createElement("ul");
          ul.className = "toc-children list-unstyled";
          group.children.forEach(function (child) {
            var cli = document.createElement("li");
            var ca = document.createElement("a");
            ca.href = "#" + child.id;
            ca.textContent = child.textContent;
            ca.classList.add("toc-h" + child.tagName.slice(1));
            cli.appendChild(ca);
            ul.appendChild(cli);
            allLinks.push(ca);
            byId[child.id] = { item: li, link: ca };
          });
          li.appendChild(ul);
        }

        container.appendChild(li);
        groupEls.push(li);
      });

      return { byId: byId, groupEls: groupEls, allLinks: allLinks };
    }

    var desktop = buildList(desktopList);
    var mobile = buildList(mobileList);

    /* Open the section that contains `id`, close all others in this list,
       and mark that heading's link active. */
    function activate(build, id) {
      var entry = build.byId[id];
      if (!entry) { return; }
      build.groupEls.forEach(function (li) {
        li.classList.remove("open");
      });
      entry.item.classList.add("open");
      build.allLinks.forEach(function (link) {
        link.classList.remove("active");
      });
      entry.link.classList.add("active");
    }

    /* Collapse every section in a list and clear active links. */
    function closeAll(build) {
      build.groupEls.forEach(function (li) {
        li.classList.remove("open");
      });
      build.allLinks.forEach(function (link) {
        link.classList.remove("active");
      });
    }

    /* Clicking an h2 only toggles its children (accordion: clicking another
       closes the previous). Active styling is scroll-driven only — clicking
       must not mark a link "active" while the smooth scroll is in flight. */
    [desktop, mobile].forEach(function (build) {
      build.groupEls.forEach(function (li) {
        var toggle = li.querySelector(".toc-h2");
        toggle.addEventListener("click", function () {
          var wasOpen = li.classList.contains("open");
          build.groupEls.forEach(function (other) {
            other.classList.remove("open");
          });
          if (!wasOpen) {
            li.classList.add("open");
          }
        });
      });
    });

    /* Scrollspy: the active heading is the last one scrolled past the top
       offset. Opening its section collapses the previous one; scrolling back
       above the first heading collapses everything. */
    var activeIdx = -1;
    function onScroll() {
      var idx = -1;
      for (var i = 0; i < headings.length; i++) {
        if (headings[i].getBoundingClientRect().top <= 90) { idx = i; }
      }
      if (idx === activeIdx) { return; }
      activeIdx = idx;
      if (idx === -1) {
        closeAll(desktop);
        closeAll(mobile);
        return;
      }
      activate(desktop, headings[idx].id);
      activate(mobile, headings[idx].id);
    }
    window.addEventListener("scroll", onScroll, { passive: true });
    onScroll();

    /* Smooth-scroll to the section (CSS scroll-margin handles the navbar offset). */
    [desktop, mobile].forEach(function (build) {
      build.allLinks.forEach(function (a) {
        a.addEventListener("click", function (e) {
          var target = document.querySelector(a.getAttribute("href"));
          if (target && target.scrollIntoView) {
            e.preventDefault();
            target.scrollIntoView({ behavior: "smooth", block: "start" });
          }
        });
      });
    });
  }

  /* ---------- Search ---------- */
  function initSearch() {
    var input = document.getElementById("search-input");
    var results = document.getElementById("search-results");
    if (!input || !results || typeof SimpleJekyllSearch === "undefined") {
      return;
    }

    var sjs = SimpleJekyllSearch({
      searchInput: input,
      resultsContainer: results,
      json: "{{ '/search.json' | relative_url }}",
      searchResultTemplate: '<li><a href="{url}"><span class="search-result-title">{title}</span><span class="search-result-content">{content}</span></a></li>',
      templateMiddleware: function (prop, value, template) {
        if (prop === "content" && value && value.length > 140) {
          return value.slice(0, 140) + "…";
        }
      },
      noResultsText: '<li class="no-results">No results found.</li>',
      limit: 10,
      fuzzy: false
    });

    function toggle() {
      results.classList.toggle("show", input.value.trim().length > 0);
    }

    /* Anchor the results panel to the input with position: fixed so it floats
       over the page instead of being clipped/scrolled by the navbar collapse
       (the mobile menu is its own scroll container). Works at every width;
       the inline styles override the CSS absolute positioning. */
    function positionResults() {
      if (!results.classList.contains("show")) { return; }
      var rect = input.getBoundingClientRect();
      results.style.position = "fixed";
      results.style.top = rect.bottom + "px";
      results.style.left = rect.left + "px";
      results.style.width = rect.width + "px";
    }

    function updateResults() {
      toggle();
      if (results.classList.contains("show")) {
        positionResults();
      } else {
        results.style.position = "";
        results.style.top = "";
        results.style.left = "";
        results.style.width = "";
      }
    }

    input.addEventListener("input", updateResults);
    input.addEventListener("focus", updateResults);
    window.addEventListener("resize", positionResults);
    var collapse = input.closest(".navbar-collapse");
    if (collapse) {
      collapse.addEventListener("scroll", function () {
        results.classList.remove("show");
      });
    }
    document.addEventListener("click", function (e) {
      if (!input.parentElement.contains(e.target)) {
        results.classList.remove("show");
      }
    });
  }

  /* ---------- Theme (light/dark) toggle ---------- */
  function initThemeToggle() {
    var btn = document.getElementById("theme-toggle");
    if (!btn) { return; }
    btn.addEventListener("click", function () {
      var current = document.documentElement.getAttribute("data-bs-theme");
      var next = current === "dark" ? "light" : "dark";
      document.documentElement.setAttribute("data-bs-theme", next);
      try { localStorage.setItem("tblr-theme", next); } catch (e) {}
    });
  }

  /* ---------- Feather icons ---------- */
  /* Buttons can declare an icon via the kramdown IAL attribute
     data-feather="name" (e.g. [Download](...){: .btn .btn-primary data-feather="download" }).
     Feather's replace() would swap the whole <a> for the SVG, so first move the
     attribute onto an injected <i> inside the link, then replace() handles it. */
  function initButtonIcons() {
    document.querySelectorAll("a.btn[data-feather]").forEach(function (a) {
      var icon = document.createElement("i");
      icon.setAttribute("data-feather", a.getAttribute("data-feather"));
      icon.setAttribute("aria-hidden", "true");
      a.removeAttribute("data-feather");
      a.insertBefore(icon, a.firstChild);
    });
  }

  function initFeather() {
    if (typeof feather === "undefined") { return; }
    initButtonIcons();
    feather.replace();
  }

  document.addEventListener("DOMContentLoaded", function () {
    initFeather();
    buildToc();
    initSearch();
    initThemeToggle();
  });
})();