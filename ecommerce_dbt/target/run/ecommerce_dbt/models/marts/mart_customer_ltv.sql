
  
    

create or replace transient table ecommerce_pipeline.marts.mart_customer_ltv
    
    
    
    as (with user_carts as (
    select *
    from ecommerce_pipeline.intermediate.int_user_carts
),

age_groups as (
    select
        *,
        case
            when age between 18 and 25 then '18-25'
            when age between 26 and 35 then '26-35'
            when age between 36 and 45 then '36-45'
            else '46+'
        end as age_group
    from user_carts
),

customer_ltv as (
    select
        age_group,
        gender,
        currency,
        department,
        count(distinct user_id)         as total_customers,
        sum(cart_total)                 as total_revenue,
        avg(cart_total)                 as avg_order_value,
        sum(cart_total) / 
            nullif(count(distinct user_id), 0) as ltv_per_customer
    from age_groups
    group by
        age_group,
        gender,
        currency,
        department
)

select * from customer_ltv
order by ltv_per_customer desc
    )
;


  