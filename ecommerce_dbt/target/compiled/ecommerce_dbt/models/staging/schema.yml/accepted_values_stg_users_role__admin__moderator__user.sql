
    
    

with all_values as (

    select
        role as value_field,
        count(*) as n_records

    from ecommerce_pipeline.staging.stg_users
    group by role

)

select *
from all_values
where value_field not in (
    'admin','moderator','user'
)


