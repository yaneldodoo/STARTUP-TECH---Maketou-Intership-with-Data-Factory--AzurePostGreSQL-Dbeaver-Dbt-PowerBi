WITH source AS (

    SELECT *
    FROM {{ source('public', 'raw_payment') }}

),

renamed AS (

    SELECT

        "id" AS numero_commande,

        CAST(REPLACE("amount", ',', '') AS numeric) AS montant,

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
        ) AS date_paiement,

        "status" AS statut_paiement,
        "currency" AS devise_paiement,
        "provider" AS processeur,

        "failure_details__failureerrormessage" AS erreur_paiement,
        "failure_details__paymentmethod" AS methode_paiement,
        "failure_details__gatewayname" AS passerelle_paiement,

        CASE 
            WHEN "currency" = 'CDF' THEN 'RDC'
            WHEN "currency" = 'KES' THEN 'Kenya'
            WHEN "currency" = 'NGN' THEN 'Nigeria'
            WHEN "currency" = 'XOF' THEN 'UEMOA'
            WHEN "currency" = 'MZN' THEN 'Mozambique'
            WHEN "currency" = 'RWF' THEN 'Rwanda'
            WHEN "currency" = 'UGX' THEN 'Ouganda'
            WHEN "currency" = 'TZS' THEN 'Tanzanie'
            WHEN "currency" = 'ZMW' THEN 'Zambie'
            WHEN "currency" = 'XAF' THEN 'CEMAC'
            WHEN "currency" = 'GHS' THEN 'Ghana'
            ELSE 'Inconnu'
        END AS zonemondiale

    FROM source

)

SELECT *
FROM renamed
