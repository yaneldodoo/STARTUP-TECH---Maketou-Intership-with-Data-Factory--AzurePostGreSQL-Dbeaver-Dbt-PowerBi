SELECT

    kyc_attempt_number,
    duree_kyc

FROM {{ ref('int_kyc') }}
WHERE statut_kyc = 'validé'