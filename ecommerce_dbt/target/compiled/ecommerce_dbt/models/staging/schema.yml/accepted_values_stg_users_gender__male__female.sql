
    
    

with all_values as (

    select
        gender as value_field,
        count(*) as n_records

    from ecommerce_pipeline.staging.stg_users
    group by gender

)

select *
from all_values
where value_field not in (
    'male','female'
)


