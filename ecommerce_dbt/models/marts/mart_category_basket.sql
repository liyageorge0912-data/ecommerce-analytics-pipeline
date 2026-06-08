with cart_items as (
    select *
    from {{ ref('stg_carts_items') }}
),

products as (
    select *
    from {{ ref('stg_products') }}
),

category_basket as (
    select
        p.category,
        count(distinct ci.cart_id)      as number_of_orders,
        sum(ci.line_total)              as total_revenue,
        avg(ci.line_total)              as avg_line_value,
        sum(ci.quantity)                as total_units_sold,
        avg(ci.quantity)                as avg_quantity_per_order,
        avg(p.price)                    as avg_product_price
    from cart_items ci
    left join products p
        on ci.product_id = p.product_id
    group by p.category
)

select * from category_basket
order by total_revenue desc