
  
    

create or replace transient table ecommerce_pipeline.marts.mart_basket_analysis
    
    
    
    as (with user_carts as (
    select *
    from ecommerce_pipeline.intermediate.int_user_carts
),

basket_analysis as (
    select
        currency,
        count(distinct cart_id) as number_of_orders,
        avg(cart_total)         as avg_basket_value,
        avg(total_quantity)     as avg_items_per_basket,
        avg(total_products)     as avg_products_per_basket,
        sum(cart_total)         as total_revenue,
        min(cart_total)         as min_basket_value,
        max(cart_total)         as max_basket_value
    from user_carts
    group by currency
)

select * from basket_analysis
order by total_revenue desc
    )
;


  