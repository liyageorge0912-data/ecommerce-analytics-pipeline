with users as (
    select *
    from ecommerce_pipeline.dev_staging.stg_users
),

carts as (
    select *
    from ecommerce_pipeline.dev_staging.stg_carts
),

joined as (
    select
        u.user_id,
        u.first_name,
        u.last_name,
        u.age,
        u.gender,
        u.city,
        u.state,
        u.currency,
        u.department,
        u.job_title,
        u.role,
        c.cart_id,
        c.cart_total,
        c.discounted_total,
        c.total_products,
        c.total_quantity
    from users u
    left join carts c
        on u.user_id = c.user_id
)

select * from joined