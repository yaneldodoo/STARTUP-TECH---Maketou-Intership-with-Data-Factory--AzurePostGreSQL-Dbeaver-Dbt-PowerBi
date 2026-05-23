with source as (
    select * 
    from {{ source('public', 'raw_boutique') }}
),

clean as (
    select 
        id,

        to_timestamp(
            case 
                when "created_at" ilike 'janvier%' then replace("created_at", 'janvier', 'January')
                when "created_at" ilike 'février%' then replace("created_at", 'février', 'February')
                when "created_at" ilike 'mars%' then replace("created_at", 'mars', 'March')
                when "created_at" ilike 'avril%' then replace("created_at", 'avril', 'April')
                when "created_at" ilike 'mai%' then replace("created_at", 'mai', 'May')
                when "created_at" ilike 'juin%' then replace("created_at", 'juin', 'June')
                when "created_at" ilike 'juillet%' then replace("created_at", 'juillet', 'July')
                when "created_at" ilike 'août%' then replace("created_at", 'août', 'August')
                when "created_at" ilike 'septembre%' then replace("created_at", 'septembre', 'September')
                when "created_at" ilike 'octobre%' then replace("created_at", 'octobre', 'October')
                when "created_at" ilike 'novembre%' then replace("created_at", 'novembre', 'November')
                when "created_at" ilike 'décembre%' then replace("created_at", 'décembre', 'December')
            end,
            'Month DD, YYYY, HH12:MI AM'
        ) as created_at,

        case 
            when "currency_code" = 'CDF' then 'République démocratique du Congo'
            when "currency_code" = 'KES' then 'Kenya'
            when "currency_code" = 'NGN' then 'Nigeria'
            when "currency_code" = 'XOF' then 'UEMOA (Afrique de l’Ouest)'
            when "currency_code" = 'MZN' then 'Mozambique'
            when "currency_code" = 'RWF' then 'Rwanda'
            when "currency_code" = 'SLE' then 'Sierra Leone'
            when "currency_code" = 'MWK' then 'Malawi'
            when "currency_code" = 'UGX' then 'Ouganda'
            when "currency_code" = 'TZS' then 'Tanzanie'
            when "currency_code" = 'ZMW' then 'Zambie'
            when "currency_code" = 'XAF' then 'CEMAC (Afrique centrale)'
            when "currency_code" = 'GHS' then 'Ghana'
            else 'Inconnu'
        end as pays

    from source
)

select *
from clean