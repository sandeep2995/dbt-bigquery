select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    {{ cents_to_dollars('amount') }} as amount
from {{ source("stripe", "payment") }}
