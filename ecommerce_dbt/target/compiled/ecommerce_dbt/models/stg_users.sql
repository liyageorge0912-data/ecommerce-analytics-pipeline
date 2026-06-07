with source as (
    select raw_data
    from ecommerce_pipeline.raw.raw_users
),

flattened as (
    select
        f.value:id::NUMBER                    as user_id,
        f.value:firstName::STRING             as first_name,
        f.value:lastName::STRING              as last_name,
        f.value:age::NUMBER                   as age,
        f.value:gender::STRING                as gender,
        f.value:email::STRING                 as email,
        f.value:phone::STRING                 as phone,
        f.value:birthDate::STRING             as birth_date,
        f.value:role::STRING                  as role,
        f.value:address:city::STRING          as city,
        f.value:address:state::STRING         as state,
        f.value:bank:currency::STRING         as currency,
        f.value:bank:cardType::STRING         as card_type,
        f.value:company:department::STRING    as department,
        f.value:company:title::STRING         as job_title
    from source s,
    lateral flatten(input => s.raw_data) f
)

select * from flattened