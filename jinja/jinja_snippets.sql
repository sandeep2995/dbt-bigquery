{#
{% for i in range(10) %}
select {{ i }} as number {% if not loop.last %} union all {% endif %}
{% endfor %}
#}

{% set fruits = ['apple', 'banana', 'orange', 'mango'] %}
{%- for fruit in fruits -%}
    My favorite fruit is {{ fruit }}
{% endfor %}
However, the first fruit is {{ fruits[0] }}

{% set fruit_colors = {'orange': 'orange', 'apple': 'red', 'banana': 'yellow'} %}
{%- for fruit, color in fruit_colors.items() -%}
    Fruit {{ fruit }} is of color {{ color }}
    {% if fruit == 'orange' %}
        {{ fruit }} has same name as its color.
    {% else %}
        {{ fruit }} does not have a name as its color.
    {% endif %}
{% endfor %}
However, the color of banana is {{ fruit_colors['banana'] }}

