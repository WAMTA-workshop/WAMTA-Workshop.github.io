---
layout: page
slide_id: 3
year: "2025"
---

{% assign year = page.year | default: site.current_year %}
{% assign year_data = site.data.years[year] %}
{% assign conference = year_data.conference %}

{% include pages/2025/registration.md %}
