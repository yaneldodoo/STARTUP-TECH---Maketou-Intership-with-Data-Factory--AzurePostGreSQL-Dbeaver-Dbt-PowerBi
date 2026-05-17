SELECT
    date_trunc('month', date_creation_kyc) as mois_creation, 
    date_trunc('month', date_validation_kyc) as mois_validation,
    date_creation_kyc,
    date_validation_kyc,
    statut_kyc,
    COUNT(*) AS nb_kyc,
    COUNT(DISTINCT id_utilisateur) AS nb_utilisateurs,
    duree_kyc
FROM {{ ref('int_kyc') }}
GROUP BY 1,2,3,4,5,8