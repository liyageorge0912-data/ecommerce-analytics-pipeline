
  create or replace   view ecommerce_pipeline.staging.stg_products
  
  
  
  
  as (
    with source as (
    select raw_data
    from ecommerce_pipeline.raw.raw_products
),

flattened as (
    select
        f.value:id::NUMBER                  as product_id,
        f.value:title::STRING               as product_name,
        f.value:category::STRING            as category,
        f.value:brand::STRING               as brand,
        f.value:price::FLOAT                as price,
        f.value:discountPercentage::FLOAT   as discount_percentage,
        f.value:rating::FLOAT               as rating,
        f.value:stock::NUMBER               as stock,
        f.value:availabilityStatus::STRING  as availability_status,
        f.value:returnPolicy::STRING        as return_policy,
        f.value:shippingInformation::STRING as shipping_information
    from source s,
    lateral flatten(input => s.raw_data) f
)

select * from flattened
  );

