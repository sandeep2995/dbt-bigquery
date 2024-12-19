{% macro clean_stale_models(
    project=target.project, dataset=target.dataset, days=7, dry_run=True
) %}

    {% set case_condition %}
        CASE
            WHEN table_type = 'VIEW' THEN
                table_type
            ELSE
                'TABLE'
        END
    {% endset %}

    {% set get_drop_commands_query %}
        SELECT 
            table_catalog,
            table_schema,
            table_name, 
            table_type,
            creation_time,
            {{ case_condition }} as drop_type,
            CONCAT('DROP ', {{ case_condition }}, ' IF EXISTS ', table_catalog, '.', table_schema, '.', table_name)

        FROM 
            `{{project}}.{{dataset}}.INFORMATION_SCHEMA.TABLES`
        WHERE 
            table_type IN ('BASE TABLE', 'VIEW') AND
            creation_time <= current_timestamp - interval {{ days }} day
        ORDER BY 
            creation_time DESC

    {% endset %}

    {{ log("\nCreating cleanup queries for Tables and Views...", info=True) }}
    {% set drop_queries = run_query(get_drop_commands_query).columns[6].values() %}

    {% for drop_query in drop_queries %}
        {% if execute and not dry_run %}
            {{
                log(
                    "Deleting the Table/View using the command: " ~ drop_query,
                    info=True,
                )
            }}
            {% do run_query(drop_query) %}
        {% else %} {{ log(drop_query, info=True) }}
        {% endif %}
    {% endfor %}

{% endmacro %}
