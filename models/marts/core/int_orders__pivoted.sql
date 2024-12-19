{%- set payment_methods = ['credit_card', 'bank_transfer', 'coupon', 'gift_card'] -%}

with payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

pivoted as (
    select orderid as order_id,
    {% for paymentmethod in payment_methods -%}
        sum(case when paymentmethod = '{{ paymentmethod }}' then amount else 0 end) as {{ paymentmethod }}_amount
        {%- if not loop.last -%}
            ,
        {%- endif %}
    {% endfor %}
    from payments
    where status = 'success'
    group by order_id
    order by order_id
)

select * from pivoted