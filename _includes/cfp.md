{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign cfp = year_data.cfp %}

{% if cfp %}
<div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2">
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 text-justify conference-text" markdown="1">

**Call For Papers**

{{ cfp.description }}
  </div>
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 conference-text text-justify" markdown="1">

{% if cfp.special_issue %}{{ cfp.special_issue }}{% endif %}

{% if cfp.contact %}{{ cfp.contact }}{% endif %}

{% if cfp.submission %}{{ cfp.submission }}{% endif %}

{% if cfp.sections %}
{% for section in cfp.sections %}
**{{ section.title }}**:

{{ section.body }}
{% endfor %}
{% endif %}

{% if cfp.dates %}
**Important Dates**:

{% for date in cfp.dates %}
**{{ date.label }}:** {{ date.value }}
{% endfor %}
{% endif %}
  </div>
</div>
{% else %}
<p>Call for papers information for {{ year }} is not yet available.</p>
{% endif %}
