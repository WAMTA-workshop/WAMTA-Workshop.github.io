{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign submission = year_data.submission %}

{% if submission %}
<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 text-justify conference-text" markdown="1">
{% for section in submission.sections %}
<div class="text-info">{{ section.title }}</div>

{{ section.body }}
{% endfor %}

{% if submission.show_contact %}{% include contact-us.html %}{% endif %}
  </div>
  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
    {% if submission.show_important_dates %}{% include card-important-dates.html %}{% endif %}
  </div>
</div>
{% else %}
<p>Submission information for {{ year }} is not yet available.</p>
{% endif %}
