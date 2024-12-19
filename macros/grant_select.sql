{% macro grant_select(project=target.project, dataset=target.dataset) %}
    {% set sql %}
        {{ log('This kind of setup is not possible for bigquery', info=True) }}
        SELECT "Sorry, Such privilige granting is not possible with me, BigQuery!" AS message;
        {#
        grant usage on schema {{ schema }} to role {{ role }};
        grant select on all tables in schema {{ schema }} to role {{ role }};
        grant usaselect on all views in schema {{ schema }} to role {{ role }};
        #}
    {% endset %}
    {{ log("Executing the sql statement...", info=True) }}
    {% do run_query(sql) %}
    {{ log("Previliges successfully granted...", info=True) }}
{% endmacro %}
