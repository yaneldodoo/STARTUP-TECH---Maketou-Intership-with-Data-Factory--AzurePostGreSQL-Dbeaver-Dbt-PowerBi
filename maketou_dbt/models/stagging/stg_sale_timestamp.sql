with source as 
( select * 
FROM {{ source('public', 'raw_sale_timestamp') }}
),

renamed as ( 
    Select 
    sale_id as id_vente,
TO_TIMESTAMP(
            CASE 
                WHEN "created_at" ILIKE 'janvier%' THEN REPLACE("created_at", 'janvier', 'January')
                WHEN "created_at" ILIKE 'février%' THEN REPLACE("created_at", 'février', 'February')
                WHEN "created_at" ILIKE 'mars%' THEN REPLACE("created_at", 'mars', 'March')
                WHEN "created_at" ILIKE 'avril%' THEN REPLACE("created_at", 'avril', 'April')
                WHEN "created_at" ILIKE 'mai%' THEN REPLACE("created_at", 'mai', 'May')
                WHEN "created_at" ILIKE 'juin%' THEN REPLACE("created_at", 'juin', 'June')
                WHEN "created_at" ILIKE 'juillet%' THEN REPLACE("created_at", 'juillet', 'July')
                WHEN "created_at" ILIKE 'août%' THEN REPLACE("created_at", 'août', 'August')
                WHEN "created_at" ILIKE 'septembre%' THEN REPLACE("created_at", 'septembre', 'September')
                WHEN "created_at" ILIKE 'octobre%' THEN REPLACE("created_at", 'octobre', 'October')
                WHEN "created_at" ILIKE 'novembre%' THEN REPLACE("created_at", 'novembre', 'November')
                WHEN "created_at" ILIKE 'décembre%' THEN REPLACE("created_at", 'décembre', 'December')
            END,
            'Month DD, YYYY, HH12:MI AM'
        ) AS date_vente

        from source 
)


select * from renamed