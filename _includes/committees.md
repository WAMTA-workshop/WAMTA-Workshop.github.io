{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign committees = year_data.committees %}

{% if committees %}
{% assign labels = committees.labels %}

<div class="container">
<div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2">
  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
    {% assign label = labels.organizing_committee | default: "Organizing Committee" %}
    {% include committee-card.html title=label members=committees.organizing_committee icon="fa-users" %}

    {% assign label = labels.steering_committee | default: "Steering Committee" %}
    {% include committee-card.html title=label members=committees.steering_committee icon="fa-users" %}
  </div>

  <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
    {% assign label = labels.technical_program_committee | default: "Technical Program Committee" %}
    {% include committee-card.html title=label members=committees.technical_program_committee icon="fa-users" %}
  </div>
</div>
</div>

{% else %}
<p>Committee information for {{ year }} is not yet available.</p>
{% endif %}
