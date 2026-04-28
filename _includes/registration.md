{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign registration = year_data.registration %}

{% if registration %}
<div class="row">
<div class="col text-justify conference-text">
<div markdown="1">

##### {{ registration.title }}

{{ registration.body }}

{% if registration.visa %}
##### VISA INFO:

{{ registration.visa }}
{% endif %}

</div>
</div>
</div>
{% else %}
<p>Registration information for {{ year }} is not yet available.</p>
{% endif %}
