-- ce gold est pour voir la raison de refus des kyc et le nombre de kyc refusés par raison

SELECT
    raison_refus_kyc,

    COUNT(*) AS nb_refus

FROM {{ ref('int_kyc') }}
WHERE statut_kyc = 'refusé'
GROUP BY raison_refus_kyc
ORDER BY nb_refus DESC