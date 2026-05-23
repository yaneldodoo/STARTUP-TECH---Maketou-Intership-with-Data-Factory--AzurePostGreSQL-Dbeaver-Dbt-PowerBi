select
    count(distinct u.user_id) as nb_usersanskyc
from {{ ref('int_users') }} u
left join {{ ref('int_kyc') }} k
    on u.id_utilisateur = k.id_utilisateur
where
    k.kyc_id is null
    or k.statut_kyc in ('annulé', 'refusé')