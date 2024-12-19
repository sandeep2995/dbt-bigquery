{% macro limit_data_in_dev(col_name, last_days) %}
{% if target.name == 'default' -%}
where {{ col_name }} >= current_timestamp - interval '{{ last_days }} day'
{% endif %}
{% endmacro %}