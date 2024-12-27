{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

with mock_orders as (
    select * from {{ source('dbt_svidyapu', 'mock_orders') }}
    {% if is_incremental() %}
        where order_id >= (select max(order_id)-2 from {{ this }})
    {% endif %}
    order by order_id
)

select * from mock_orders