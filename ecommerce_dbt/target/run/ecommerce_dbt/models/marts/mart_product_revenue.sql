
  
    

create or replace transient table ecommerce_pipeline.marts.mart_product_revenue
    
    
    
    as (with cart_items as (
    select *
    from ecommerce_pipeline.staging.stg_carts_items
),

products as (
    select *
    from ecommerce_pipeline.staging.stg_products
),

product_revenue as (
    select
        ci.product_id,
        ci.product_title,
        p.category,
        p.brand,
        p.price                         as unit_price,
        sum(ci.quantity)                as total_units_sold,
        sum(ci.line_total)              as total_revenue,
        sum(ci.discounted_line_total)   as total_revenue_after_discount,
        avg(ci.price)                   as avg_selling_price,
        count(distinct ci.cart_id)      as number_of_orders
    from cart_items ci
    left join products p
        on ci.product_id = p.product_id
    group by
        ci.product_id,
        ci.product_title,
        p.category,
        p.brand,
        p.price
)

select * from product_revenue
order by total_revenue desc
    )
;


  