
    
    

select
    user_id as unique_field,
    count(*) as n_records

from ecommerce_pipeline.staging.stg_users
where user_id is not null
group by user_id
having count(*) > 1


