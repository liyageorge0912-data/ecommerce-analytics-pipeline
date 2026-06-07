
  
    

create or replace transient table ecommerce_pipeline.dev_marts.mart_repeat_purchase
    
    
    
    as (with user_carts as (
    select *
    from ecommerce_pipeline.dev_intermediate.int_user_carts
),

purchase_counts as (
    select
        user_id,
        first_name,
        last_name,
        age,
        gender,
        city,
        currency,
        count(cart_id)        as number_of_orders,
        sum(cart_total)       as total_spent,
        case
            when count(cart_id) > 1 then 'Repeat Customer'
            else 'One Time Customer'
        end                   as customer_type
    from user_carts
    group by
        user_id,
        first_name,
        last_name,
        age,
        gender,
        city,
        currency
)

select * from purchase_counts
order by number_of_orders desc
    )
;


  