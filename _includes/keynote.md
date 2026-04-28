{% assign year = page.year | default: site.current_year %}
{% assign year_config = site.data.years[year].config %}
{% assign year_data = site.data.years[year] %}
{% assign keynote = year_data.keynote %}

{% if keynote and keynote.talks %}
{% for talk in keynote.talks %}
<div class="card">
  <div class="card-header text-white bg-inverse"><i class="fa fa-users mr-3" aria-hidden="true"></i>{{ talk.label }}</div>
  <div style="margin: 10px">
    <h5>{{ talk.title }}</h5>
    <p>{{ talk.speaker }}{% if talk.affiliation %}, {{ talk.affiliation }}{% endif %}{% if talk.homepage %}, <a href="{{ talk.homepage }}">{{ talk.homepage }}</a>{% endif %}</p>
    {{ talk.abstract | markdownify }}
    {% if talk.materials %}
      <ul>
        {% for material in talk.materials %}
          <li><a href="{{ material.url }}">{{ material.label }}</a></li>
        {% endfor %}
      </ul>
    {% endif %}
  </div>
</div>
{% endfor %}
{% else %}
<p>Keynote information for {{ year }} is not yet available.</p>
{% endif %}
