-- ce gold calcule le taux de conversion des paiements par mois et année, le nombre de paiements réussis et le nombre total de paiements

select 
    date_trunc('month', date_paiement) AS mois,
    date_trunc('year', date_paiement) AS annee,
 
    round(
        (
            count(*) filter (where "statut_paiement" = 'completed')::numeric
            / count(*)
        ) * 100,
        2
    ) as taux_conversion_succes
from {{ ref('int_payment') }}
group by annee, mois