{% macro cents_to_dollars(amount_column, precision=2) %}
round(1.0*{{ amount_column}}/100, {{ precision }})
{% endmacro %}