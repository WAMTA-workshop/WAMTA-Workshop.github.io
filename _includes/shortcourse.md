{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign shortcourse = year_data.shortcourse %}

{% if shortcourse %}
<div class="row mt-xs-0 mt-sm-0 mt-md-1 mt-lg-2 mt-xl-3 mb-xs-2 mb-sm-2">
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 text-justify conference-text" markdown="1">
{{ shortcourse.title }}

{{ shortcourse.description }}

{% if shortcourse.topics %}
{% for topic in shortcourse.topics -%}
- {{ topic }}
{% endfor %}
{% endif %}

{% if shortcourse.additional_topics %}
Then on top of that:

{% for topic in shortcourse.additional_topics -%}
- {{ topic }}
{% endfor %}
{% endif %}

{% if shortcourse.show_contact %}{% include contact-us.html %}{% endif %}
  </div>
  <div class="col-sm-12 col-xs-12 col-md-6 col-lg-6 col-xl-6 conference-text text-justify" markdown="1">
{{ shortcourse.logistics }}
  </div>
</div>
{% else %}
<p>Short-course information for {{ year }} is not yet available.</p>
{% endif %}
