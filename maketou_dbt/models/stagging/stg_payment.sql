WITH source AS (

    SELECT * 
    FROM {{ source('public', 'raw_payment') }}

),

renamed AS (

    SELECT
    "ID" as numero_commande,

        "Amount" AS montant,

        TO_TIMESTAMP(
            CASE 
                WHEN "Created At" ILIKE 'janvier%' THEN REPLACE("Created At", 'janvier', 'January')
                WHEN "Created At" ILIKE 'février%' THEN REPLACE("Created At", 'février', 'February')
                WHEN "Created At" ILIKE 'mars%' THEN REPLACE("Created At", 'mars', 'March')
                WHEN "Created At" ILIKE 'avril%' THEN REPLACE("Created At", 'avril', 'April')
                WHEN "Created At" ILIKE 'mai%' THEN REPLACE("Created At", 'mai', 'May')
                WHEN "Created At" ILIKE 'juin%' THEN REPLACE("Created At", 'juin', 'June')
                WHEN "Created At" ILIKE 'juillet%' THEN REPLACE("Created At", 'juillet', 'July')
                WHEN "Created At" ILIKE 'août%' THEN REPLACE("Created At", 'août', 'August')
                WHEN "Created At" ILIKE 'septembre%' THEN REPLACE("Created At", 'septembre', 'September')
                WHEN "Created At" ILIKE 'octobre%' THEN REPLACE("Created At", 'octobre', 'October')
                WHEN "Created At" ILIKE 'novembre%' THEN REPLACE("Created At", 'novembre', 'November')
                WHEN "Created At" ILIKE 'décembre%' THEN REPLACE("Created At", 'décembre', 'December')
            END,
            'Month DD, YYYY, HH12:MI AM'
        ) AS date_paiement,

        "Status" AS statut_paiement,

        "Currency" AS devise_paiement,

        "Failure Details  FailureErrorMessage" AS erreur_paiement,

        "Provider" AS processeur,

        "Failure Details  PaymentMethod" AS methode_paiement,

        "Failure Details  GatewayName" AS passerelle_paiement

    FROM source

)

SELECT * 
FROM renamed