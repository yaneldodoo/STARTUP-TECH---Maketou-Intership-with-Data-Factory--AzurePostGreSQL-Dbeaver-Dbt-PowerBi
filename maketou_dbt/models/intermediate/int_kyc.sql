select 
    id_utilisateur,
    id_kyc,
    date_validation_kyc,
    date_creation_kyc,
    statut_kyc,
    raison_refus_kyc
FROM {{ ref('stg_kyc.sql') }}