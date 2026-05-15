select 
    statut_kyc,
    raison_refus_kyc,
    count (*) filter (status_kyc = 'validé') as kyc_validé,
    count (*) filter (status_kyc = 'refusé') as kyc_refusé,
    count (*) filter (status_kyc = 'en cours') as kyc_en_cours,
    count (*) filter (status_kyc = 'annulé') as kyc_annulé,
    avg ( date_validation_kyc - date_creation_kyc ) as duree_validation_kyc,
    count (distinct id_utilisateur) as nombre_utilisateurs,
    count (distinct id_kyc) as nombre_kyc,

from {{ ref('int_kyc') }}
group by 1,2