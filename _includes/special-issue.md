{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign special_issue = year_data.special_issue %}

{% if special_issue %}
<div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2">
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 text-justify conference-text" markdown="1">
{{ special_issue.description }}

{% if special_issue.editors %}
The special issue will be edited by

{% for editor in special_issue.editors -%}
- {{ editor }}
{% endfor %}
{% endif %}

{% if special_issue.show_contact %}{% include contact-us.html %}{% endif %}
  </div>
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 conference-text text-justify" markdown="1">
{{ special_issue.submission }}

{% if special_issue.dates %}
{% for date in special_issue.dates %}
**{{ date.label }}:** {{ date.value }}
{% endfor %}
{% endif %}
  </div>
</div>
{% else %}
<p>Special issue information for {{ year }} is not yet available.</p>
{% endif %}
