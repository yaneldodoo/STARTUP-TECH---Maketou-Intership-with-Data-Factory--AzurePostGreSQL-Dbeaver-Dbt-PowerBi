-- ce gold est pour voir la durée moyenne que fais une demande  de kyc avant d'etre validé
-- un kyc est une demande de validation d'identité pour un utilisateur

SELECT

    kyc_attempt_number,
    duree_kyc

FROM {{ ref('int_kyc') }}
WHERE statut_kyc = 'validé'