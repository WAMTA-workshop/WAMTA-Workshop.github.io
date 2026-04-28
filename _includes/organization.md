{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign committees = year_data.committees %}

{% if committees %}
{% assign labels = committees.labels %}

<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
    {% assign label = labels.program_chair | default: "Program Chairs" %}
    {% include committee-card.html title=label members=committees.program_chair %}

    {% assign label = labels.steering_committee | default: "Steering Committee" %}
    {% include committee-card.html title=label members=committees.steering_committee %}

    {% assign label = labels.technical_program_chair | default: "Technical Program Chairs" %}
    {% include committee-card.html title=label members=committees.technical_program_chair %}

    {% assign label = labels.webmaster | default: "Webmaster" %}
    {% include committee-card.html title=label members=committees.webmaster %}
  </div>

  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
    {% assign label = labels.technical_program_committee | default: "Technical Program Committee" %}
    {% include committee-card.html title=label members=committees.technical_program_committee %}
  </div>
</div>

{% else %}
<p>Organization information for {{ year }} is not yet available.</p>
{% endif %}
