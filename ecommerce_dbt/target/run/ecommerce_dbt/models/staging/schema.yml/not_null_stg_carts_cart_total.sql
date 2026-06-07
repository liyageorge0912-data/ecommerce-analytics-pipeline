
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cart_total
from ecommerce_pipeline.dev_staging.stg_carts
where cart_total is null



  
  
      
    ) dbt_internal_test