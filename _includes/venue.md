{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign venue = year_data.venue %}

{% if venue %}
<div class="container"><div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2"><div class="col text-muted" markdown="1">
{{ venue.intro }}

{% for section in venue.sections %}
{% if section.title %}<div class="text-info">{{ section.title }}</div>{% endif %}

{{ section.body }}

{% if section.map %}{% include map-embed.html map=section.map %}{% endif %}
{% endfor %}
</div></div></div>
{% else %}
<p>Venue information for {{ year }} is not yet available.</p>
{% endif %}
