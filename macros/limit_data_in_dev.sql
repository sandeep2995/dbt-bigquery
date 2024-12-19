{% macro limit_data_in_dev(col_name, last_days) %}
{% if target.name == 'default' -%}
where {{ col_name }} >= current_datetime - interval {{ last_days }} day
{% endif %}
{% endmacro %}