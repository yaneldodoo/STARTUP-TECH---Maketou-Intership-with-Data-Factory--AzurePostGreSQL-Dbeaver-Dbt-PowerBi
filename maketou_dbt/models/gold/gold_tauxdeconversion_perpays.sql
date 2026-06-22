-- ce gold calcule le taux de conversion des paiements par pays,

select 
"zonemondiale" as pays ,
    round(
        (
            count(*) filter (where "statut_paiement" = 'completed')::numeric
            / count(*)
        ) * 100,
        2
    ) as taux_conversion_succes
from {{ ref('int_payment') }}
group by pays