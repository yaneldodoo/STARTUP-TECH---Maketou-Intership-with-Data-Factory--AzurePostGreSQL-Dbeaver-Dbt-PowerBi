with source as (
    select * 
    from {{ source('public', 'raw_boutique') }}
),

clean as (
    select 
        id,

        to_timestamp(
            case 
                when "Created At" ilike 'janvier%' then replace("Created At", 'janvier', 'January')
                when "Created At" ilike 'février%' then replace("Created At", 'février', 'February')
                when "Created At" ilike 'mars%' then replace("Created At", 'mars', 'March')
                when "Created At" ilike 'avril%' then replace("Created At", 'avril', 'April')
                when "Created At" ilike 'mai%' then replace("Created At", 'mai', 'May')
                when "Created At" ilike 'juin%' then replace("Created At", 'juin', 'June')
                when "Created At" ilike 'juillet%' then replace("Created At", 'juillet', 'July')
                when "Created At" ilike 'août%' then replace("Created At", 'août', 'August')
                when "Created At" ilike 'septembre%' then replace("Created At", 'septembre', 'September')
                when "Created At" ilike 'octobre%' then replace("Created At", 'octobre', 'October')
                when "Created At" ilike 'novembre%' then replace("Created At", 'novembre', 'November')
                when "Created At" ilike 'décembre%' then replace("Created At", 'décembre', 'December')
            end,
            'Month DD, YYYY, HH12:MI AM'
        ) as created_at,

        cast("Currency Code" as varchar) as monnaie

    from source
)
