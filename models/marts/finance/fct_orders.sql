select order_id, customer_id, amount
from {{ ref("stg_jaffle_shop__customers") }} c
join {{ ref('stg_jaffle_shop__orders') }} o using (customer_id)
join {{ ref("stg_stripe__payments") }} p using (order_id)
order by order_id
