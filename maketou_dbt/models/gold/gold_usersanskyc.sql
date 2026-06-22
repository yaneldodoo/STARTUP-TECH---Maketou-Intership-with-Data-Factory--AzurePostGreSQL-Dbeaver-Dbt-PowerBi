-- ce gold est fait pour voir le nombre d'utilisateurs sans KYC

select
    u.id_utilisateur as nb_usersanskyc
from {{ ref('int_users') }} u
left join {{ ref('int_kyc') }} k
    on u.id_utilisateur = k.id_utilisateur
where
    k.id_kyc is null