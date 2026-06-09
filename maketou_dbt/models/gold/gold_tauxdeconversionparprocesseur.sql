-- ce gold est pour calculer le taux de conversion par orchestrateur

select 
passerelle_paiement,
    round(
        (
            count(*) filter (where "statut_paiement" = 'completed')::numeric
            / count(*)
        ) * 100,
        2
    ) as taux_conversion_succes
from {{ ref('int_payment') }}
group by passerelle_paiement