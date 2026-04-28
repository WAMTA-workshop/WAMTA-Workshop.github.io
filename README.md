# WAMTA Workshop Website

This repository contains the multi-year Jekyll site for the Workshop on
Asynchronous Many-Task Systems and Applications (WAMTA). The current workshop
edition is selected by `current_year` in `_config.yml`; root pages such as
`/program` render that year, while historical pages remain available under
year-prefixed URLs such as `/2024/program`.

## Structure

- `_config.yml` contains site-wide settings and `current_year`.
- `_layouts/default.html` resolves the active year and renders the common site
  shell.
- `_layouts/page.html` wraps standard content pages.
- `_includes/*.md` and `_includes/*.html` contain shared page templates and
  reusable cards.
- `_data/years/<year>/` contains all year-specific content.
- `2023/`, `2024/`, `2025/`, and `2026/` contain thin archive wrappers.
- Root pages such as `index.md`, `cfp.md`, and `program.md` are thin aliases for
  the current year.
- `assets/years/<year>/` contains year-specific media.

Each public page follows the AMTE-style wrapper pattern:

```markdown
---
layout: page
year: "2026"
---

{% include program.md %}
```

Root pages omit `year`, so shared includes fall back to `site.current_year`.

## Year Data

Each `_data/years/<year>/` directory is split by concern:

- `config.yml`: title, short title, email, description, location, dates, logo,
  slideshow, and social links.
- `important_dates.yml`: important dates shown by the Important Dates card.
  Each entry has an ISO `date` (`YYYY-MM-DD`) or the literal string `TBA`,
  plus a `text` description and an optional `timezone`. Past-due strikethrough
  is derived from the date at render time, so do not add a `pass_due` field.
- `news.yml`: news entries shown by the News card. Each entry has `text` and
  an optional ISO `date`.
- `sponsors.yml`: sponsor names and logo paths.
- `committees.yml`: chairs, steering committee, technical program committee,
  webmaster, and organizing committee data when present. An optional top-level
  `labels:` mapping overrides the displayed card title per group (for example
  `program_chair: "Local organizers"` or `steering_committee: "Scientific
  Committee"`); without `labels`, the include falls back to canonical names.
- Page data files such as `home.yml`, `cfp.yml`, `submission.yml`,
  `program.yml`, `venue.yml`, `registration.yml`, `keynote.yml`,
  `shortcourse.yml`, `events.yml`, and `special_issue.yml` store page-specific
  semantic fields for years that have those pages. For example, `home.yml`
  contains `title`, `lead`, `overview`, `objectives`, `topics`, and sidebar
  toggles; `program.yml` contains `intro`, `social_events`, `schedule`,
  `links`, and `show_contact`; `keynote.yml` contains `talks`; and
  `events.yml` contains `items`.

Shared page includes render those semantic fields directly. YAML owns facts and
prose; includes own layout. Do not put Bootstrap classes, raw layout HTML,
Kramdown inline attributes, or generic renderer keys in page data.

Shared includes resolve the active year with:

```liquid
{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
```

Navigation is also AMTE-style: `_includes/header.html` owns the fixed label and
path order, and optional links are shown when the corresponding year data exists.
For example, `program.yml` enables Program, `shortcourse.yml` enables Short
course, `events.yml` enables Events, and `special_issue.yml` enables Special
Issue. Do not add per-year `navbar.yml` files.

To keep a page reachable but absent from the menu (matching the originals'
pattern of linking to `/submission`, `/shortcourse`, `/special-issue`, or
`/events` only from CFP/Program copy), set `nav_hidden: true` at the top of the
page-data YAML. The wrapper page still renders; only the nav link is skipped.

## Local Development

Install dependencies:

```sh
bundle install
```

Build the site:

```sh
bundle exec jekyll build
```

Validate the year-data shape:

```sh
ruby scripts/validate-data-shape.rb
```

Serve locally:

```sh
bundle exec jekyll serve
```

## Deployment

GitHub Pages deployment is handled by `.github/workflows/jekyll.yml` on pushes
to `main` and via manual workflow dispatch.

## Adding A Year

1. Create `_data/years/<year>/`.
2. Add `config.yml`, `important_dates.yml`, `news.yml`, `sponsors.yml`,
   `committees.yml`, and the page data files needed for that year.
3. Add thin wrapper pages under `<year>/` for the pages that should be archived.
4. Add year-specific media under `assets/years/<year>/`.
5. Update `current_year` in `_config.yml` when the new year should become the
   root site.