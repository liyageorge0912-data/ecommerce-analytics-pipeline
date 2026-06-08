with source as (
    select raw_data
    from ecommerce_pipeline.raw.raw_carts
),

carts_flattened as (
    select
        f.value:id::NUMBER      as cart_id,
        f.value:userId::NUMBER  as user_id,
        f.value:products        as products
    from source s,
    lateral flatten(input => s.raw_data) f
),

cart_items as (
    select
        c.cart_id,
        c.user_id,
        p.value:id::NUMBER              as product_id,
        p.value:title::STRING           as product_title,
        p.value:price::FLOAT            as price,
        p.value:quantity::NUMBER        as quantity,
        p.value:total::FLOAT            as line_total,
        p.value:discountedTotal::FLOAT  as discounted_line_total
    from carts_flattened c,
    lateral flatten(input => c.products) p
)

select * from cart_items