SELECT
    raison_refus_kyc,

    COUNT(*) AS nb_refus

FROM {{ ref('int_kyc') }}
WHERE statut_kyc = 'refusé'
GROUP BY raison_refus_kyc
ORDER BY nb_refus DESC