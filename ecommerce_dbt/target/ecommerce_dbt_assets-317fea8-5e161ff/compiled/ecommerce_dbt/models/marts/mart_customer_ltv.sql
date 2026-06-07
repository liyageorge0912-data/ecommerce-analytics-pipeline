with user_carts as (
    select *
    from ecommerce_pipeline.dev_intermediate.int_user_carts
),

customer_ltv as (
    select
        user_id,
        first_name,
        last_name,
        age,
        gender,
        city,
        state,
        currency,
        department,
        job_title,
        sum(cart_total)         as total_spent,
        sum(discounted_total)   as total_spent_after_discount,
        count(distinct cart_id) as number_of_orders,
        avg(cart_total)         as average_order_value,
        sum(total_quantity)     as total_items_purchased
    from user_carts
    group by
        user_id,
        first_name,
        last_name,
        age,
        gender,
        city,
        state,
        currency,
        department,
        job_title
)

select * from customer_ltv
order by total_spent desc