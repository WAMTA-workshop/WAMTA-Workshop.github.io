{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign home = year_data.home %}

{% if home %}
<div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2">
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 text-justify conference-text" markdown="1">

##### {{ home.title }}

<div class="lead" markdown="1">
{{ home.lead }}
</div>

{{ home.overview }}

{{ home.objectives }}

{% if home.topics %}
The topics of interest include, but are by no means limited to:

{% for topic in home.topics -%}
- {{ topic }}
{% endfor %}
{% endif %}

{{ home.artifacts }}

{% if home.previous_events != empty %}
Previous events:

{% for event in home.previous_events -%}
- [{{ event.label }}]({{ event.url }}){% if event.host %} @ {{ event.host }}{% endif %}{% if event.artifacts_url %} - [Artifacts]({{ event.artifacts_url }}){% endif %}
{% endfor %}
{% endif %}

{% if home.show_contact %}{% include contact-us.html %}{% endif %}
  </div>
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6">
    {% if home.show_important_dates %}{% include card-important-dates.html %}{% endif %}
    {% if home.show_news %}{% include card-news.html %}{% endif %}
  </div>
</div>
{% if home.show_sponsors %}{% include sponsors.html %}{% endif %}
{% else %}
<p>Content for {{ year }} is not yet available.</p>
{% endif %}
