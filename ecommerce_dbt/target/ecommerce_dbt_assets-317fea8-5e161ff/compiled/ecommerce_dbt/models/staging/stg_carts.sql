with source as (
    select raw_data
    from ecommerce_pipeline.raw.raw_carts
),

flattened as (
    select
        f.value:id::NUMBER              as cart_id,
        f.value:userId::NUMBER          as user_id,
        f.value:total::FLOAT            as cart_total,
        f.value:discountedTotal::FLOAT  as discounted_total,
        f.value:totalProducts::NUMBER   as total_products,
        f.value:totalQuantity::NUMBER   as total_quantity
    from source s,
    lateral flatten(input => s.raw_data) f
)

select * from flattened