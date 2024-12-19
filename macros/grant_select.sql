{% macro grant_select(schema=target.schema, role=target.role) %}
    {% set sql %}
        grant usage on schema {{ schema }} to role {{ role }};
        grant select on all tables in schema {{ schema }} to role {{ role }};
        grant usaselect on all views in schema {{ schema }} to role {{ role }};
    {% endset %}
    {{ log('Executing the sql statement...', info=True) }}
    {% do run_query(sql) %}
{% endmacro %}