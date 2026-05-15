with source as ( 
    select * from {{ source('public', 'raw_kyc') }}
),

renamed as (select 
 "user_ID" as id_utilisateur,
 "kyc_ID" as id_kyc,
    
    to_timestamp(
        case 
            when "Updated At" ilike 'janvier%' then replace("Updated At", 'janvier', 'January')
            when "Updated At" ilike 'février%' then replace("Updated At", 'février', 'February')
            when "Updated At" ilike 'mars%' then replace("Updated At", 'mars', 'March')
            when "Updated At" ilike 'avril%' then replace("Updated At", 'avril', 'April')
            when "Updated At" ilike 'mai%' then replace("Updated At", 'mai', 'May')
            when "Updated At" ilike 'juin%' then replace("Updated At", 'juin', 'June')
            when "Updated At" ilike 'juillet%' then replace("Updated At", 'juillet', 'July')
            when "Updated At" ilike 'août%' then replace("Updated At", 'août', 'August')
            when "Updated At" ilike 'septembre%' then replace("Updated At", 'septembre', 'September')
            when "Updated At" ilike 'octobre%' then replace("Updated At", 'octobre', 'October')
            when "Updated At" ilike 'novembre%' then replace("Updated At", 'novembre', 'November')
            when "Updated At" ilike 'décembre%' then replace("Updated At", 'décembre', 'December')
        end,
        'Month DD, YYYY, HH12:MI AM'
    ) as date_validation_kyc,

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
    ) as date_creation_kyc,

case  
    when "Status" ilike 'validated%' then 'validé'
    when "Status" ilike 'rejected%'  then 'refusé'
    when "Status" ilike 'pending%'  then 'en cours'
    when "Status" ilike 'canceled%'  then 'annulé'
end as statut_kyc,

"Rejection Reason" as raison_refus_kyc

from source
) 


select * from renamed