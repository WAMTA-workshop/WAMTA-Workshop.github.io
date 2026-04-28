{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign events = year_data.events %}

{% if events and events.items %}
<div class="container"><div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2"><div class="col text-muted" markdown="1">
{% for event in events.items %}
<div class="text-info">{{ event.title }}</div>
![{{ event.alt }}]({{ event.image_path }})
{% endfor %}
</div></div></div>
{% else %}
<p>Event information for {{ year }} is not yet available.</p>
{% endif %}
