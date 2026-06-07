
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        gender as value_field,
        count(*) as n_records

    from ecommerce_pipeline.dev_staging.stg_users
    group by gender

)

select *
from all_values
where value_field not in (
    'male','female'
)



  
  
      
    ) dbt_internal_test