-- ce gold est pour voir les users avec kyc non validé mais avec des ventes

select
    id_utilisateur as nb_useraveckycnonvalidé
from {{ ref('int_kyc') }}
where
    statut_kyc in ('annulé', 'refusé', 'en cours') 