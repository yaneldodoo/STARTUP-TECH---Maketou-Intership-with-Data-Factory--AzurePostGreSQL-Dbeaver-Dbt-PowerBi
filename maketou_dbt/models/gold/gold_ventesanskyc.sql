-- Ce mart est pour trouver les users qui font des ventes sans avoir validé leur kyc

select count(distinct u.user_id) as nb_ventesanskyc
from {{ ref('int_users') }} u
join {{ ref('int_payment') }} p
    on u.id_utilisateur = p.id_utilisateur
left join {{ ref('int_kyc') }} k
    on u.id_utilisateur = k.id_utilisateur
where
    p.statut_paiement = 'completed'
    and (k.kyc_id is null or k.statut_kyc in ('annulé', 'refusé'))