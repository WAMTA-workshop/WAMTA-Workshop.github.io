---
layout: page
slide_id: 0
year: "2024"
---

{% assign year = page.year | default: site.current_year %}
{% assign year_data = site.data.years[year] %}
{% assign conference = year_data.conference %}

{% include pages/2024/venue.md %}
