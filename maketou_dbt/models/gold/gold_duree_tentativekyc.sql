SELECT

    kyc_attempt_number,

    AVG(duree_kyc) AS avg_duration

FROM {{ ref('int_kyc') }}
WHERE statut_kyc = 'validé'
GROUP BY kyc_attempt_number