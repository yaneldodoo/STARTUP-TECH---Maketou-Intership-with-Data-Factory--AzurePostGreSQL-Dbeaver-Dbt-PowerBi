
with source as (
    select *
    from {{ source('public', 'raw_store_accees_2') }}
),

renamed as (
    select
        coalesce(user_id::text, 'unknown') as id_utilisateur_acces,
        coalesce(store_id::text, 'unknown') as id_boutique_acces,

        to_timestamp(
            case
                when created_at ilike 'janvier%' then replace(created_at, 'janvier', 'January')
                when created_at ilike 'février%' then replace(created_at, 'février', 'February')
                when created_at ilike 'mars%' then replace(created_at, 'mars', 'March')
                when created_at ilike 'avril%' then replace(created_at, 'avril', 'April')
                when created_at ilike 'mai%' then replace(created_at, 'mai', 'May')
                when created_at ilike 'juin%' then replace(created_at, 'juin', 'June')
                when created_at ilike 'juillet%' then replace(created_at, 'juillet', 'July')
                when created_at ilike 'août%' then replace(created_at, 'août', 'August')
                when created_at ilike 'septembre%' then replace(created_at, 'septembre', 'September')
                when created_at ilike 'octobre%' then replace(created_at, 'octobre', 'October')
                when created_at ilike 'novembre%' then replace(created_at, 'novembre', 'November')
                when created_at ilike 'décembre%' then replace(created_at, 'décembre', 'December')
            end,
            'Month DD, YYYY, HH12:MI AM'
        ) as date

    from source
)

select * from renamed