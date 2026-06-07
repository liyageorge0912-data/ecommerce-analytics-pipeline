
    
    

select
    cart_id as unique_field,
    count(*) as n_records

from ecommerce_pipeline.staging.stg_carts
where cart_id is not null
group by cart_id
having count(*) > 1


