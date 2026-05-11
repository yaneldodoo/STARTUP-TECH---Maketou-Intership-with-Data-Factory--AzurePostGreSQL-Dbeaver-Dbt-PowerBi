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

        case 
            when "Currency Code" = 'CDF' then 'République démocratique du Congo'
            when "Currency Code" = 'KES' then 'Kenya'
            when "Currency Code" = 'NGN' then 'Nigeria'
            when "Currency Code" = 'XOF' then 'UEMOA (Afrique de l’Ouest)'
            when "Currency Code" = 'MZN' then 'Mozambique'
            when "Currency Code" = 'RWF' then 'Rwanda'
            when "Currency Code" = 'SLE' then 'Sierra Leone'
            when "Currency Code" = 'MWK' then 'Malawi'
            when "Currency Code" = 'UGX' then 'Ouganda'
            when "Currency Code" = 'TZS' then 'Tanzanie'
            when "Currency Code" = 'ZMW' then 'Zambie'
            when "Currency Code" = 'XAF' then 'CEMAC (Afrique centrale)'
            when "Currency Code" = 'GHS' then 'Ghana'
            else 'Inconnu'
        end as pays

    from source
)

select *
from clean