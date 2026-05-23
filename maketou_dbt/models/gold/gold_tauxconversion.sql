select 
    round(
        (
            count(*) filter (where "statut_paiement" = 'completed')::numeric
            / count(*)
        ) * 100,
        2
    ) as taux_conversion_succes
from {{ ref('int_payment') }}