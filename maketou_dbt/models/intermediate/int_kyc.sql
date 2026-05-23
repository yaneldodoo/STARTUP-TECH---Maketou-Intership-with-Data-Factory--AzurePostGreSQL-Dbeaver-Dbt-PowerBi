WITH base AS (

    SELECT
        id_utilisateur,
        id_kyc,
        statut_kyc,
        raison_refus_kyc,
        date_creation_kyc,
        date_validation_kyc

    FROM {{ ref('stg_kyc') }}

),

enriched AS (

    SELECT
        *,

        -- durée du KYC (null si pas encore validé)
        (date_validation_kyc - date_creation_kyc) AS duree_kyc,

        -- flag statut 
        CASE WHEN statut_kyc = 'validé' THEN 1 ELSE 0 END AS is_validated,
        CASE WHEN statut_kyc = 'refusé' THEN 1 ELSE 0 END AS is_refused,
        CASE WHEN statut_kyc = 'en cours' THEN 1 ELSE 0 END AS is_pending,
        CASE WHEN statut_kyc = 'annulé' THEN 1 ELSE 0 END AS is_cancelled,

        -- numéro de tentative par user
        ROW_NUMBER() OVER (
            PARTITION BY id_utilisateur
            ORDER BY date_creation_kyc
        ) AS kyc_attempt_number,

        -- nombre total de tentatives par user
        COUNT(*) OVER (
            PARTITION BY id_utilisateur
        ) AS total_attempts_user

    FROM base
),

final AS (

    SELECT
        *,
        
        -- première tentative de validation (NULL si jamais validé)
      MIN(kyc_attempt_number) FILTER (WHERE statut_kyc = 'validé')
OVER (PARTITION BY id_utilisateur)
AS attempt_at_validation

  FROM enriched

)

SELECT *
FROM final