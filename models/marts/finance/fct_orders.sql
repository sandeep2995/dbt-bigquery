select orderid as order_id, customer_id, amount
from {{ ref("stg_jaffle_shop__customers") }} c
join {{ ref("stg_stripe__payments") }} p on c.customer_id = p.id
