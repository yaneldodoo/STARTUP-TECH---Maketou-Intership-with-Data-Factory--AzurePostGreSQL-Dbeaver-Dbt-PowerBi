with source as ( 
    select * from {{ source('public', 'raw_kyc') }}
),

renamed as (select 
 "user_id" as id_utilisateur,
 "kyc_id" as id_kyc,
    
    to_timestamp(
        case 
            when "updated_at" ilike 'janvier%' then replace("updated_at", 'janvier', 'January')
            when "updated_at" ilike 'février%' then replace("updated_at", 'février', 'February')
            when "updated_at" ilike 'mars%' then replace("updated_at", 'mars', 'March')
            when "updated_at" ilike 'avril%' then replace("updated_at", 'avril', 'April')
            when "updated_at" ilike 'mai%' then replace("updated_at", 'mai', 'May')
            when "updated_at" ilike 'juin%' then replace("updated_at", 'juin', 'June')
            when "updated_at" ilike 'juillet%' then replace("updated_at", 'juillet', 'July')
            when "updated_at" ilike 'août%' then replace("updated_at", 'août', 'August')
            when "updated_at" ilike 'septembre%' then replace("updated_at", 'septembre', 'September')
            when "updated_at" ilike 'octobre%' then replace("updated_at", 'octobre', 'October')
            when "updated_at" ilike 'novembre%' then replace("updated_at", 'novembre', 'November')
            when "updated_at" ilike 'décembre%' then replace("updated_at", 'décembre', 'December')
        end,
        'Month DD, YYYY, HH12:MI AM'
    ) as date_validation_kyc,

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
    ) as date_creation_kyc,

case  
    when "status" ilike 'validated%' then 'validé'
    when "status" ilike 'rejected%'  then 'refusé'
    when "status" ilike 'pending%'  then 'en cours'
    when "status" ilike 'canceled%'  then 'annulé'
end as statut_kyc,

"rejection_reason" as raison_refus_kyc

from source
) 


select * from renamed