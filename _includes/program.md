{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign program = year_data.program %}

{% if program %}
{{ program.intro | markdownify }}

{% if program.social_events.size > 0 %}
<div class="text-info">Social Events:</div>
<ul>
{% for event in program.social_events %}
  <li><a href="{{ event.url }}">{{ event.label }}</a></li>
{% endfor %}
</ul>
{% endif %}

{% if program.schedule %}
<div class="text-info">Scientific Program and Timetable:</div>
{% if program.schedule.kind == "timetable" %}
  {% include schedule-table.html schedule=program.schedule %}
{% elsif program.schedule.kind == "pdf" %}
  <div class="row"><div class="col-xs-12 col-sm-12 col-md-12 col-lg-10 offset-lg-1 col-xl-10 offset-xl-1">
    {% include pdf-embed.html pdf=program.schedule %}
  </div></div>
{% endif %}
{% endif %}

{% if program.links.size > 0 %}
<ul>
{% for link in program.links %}
  <li><a href="{{ link.url }}">{{ link.label }}</a></li>
{% endfor %}
</ul>
{% endif %}

{% if program.show_contact %}{% include contact-us.html %}{% endif %}
{% else %}
<p>Program information for {{ year }} is not yet available.</p>
{% endif %}
