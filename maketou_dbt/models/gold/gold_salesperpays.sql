-- ce gold est fait pour voir le montant total et moyen des ventes par pays

select 
sum(montant_vente) as montant_total_vente,
avg(montant_vente) as montant_moyen_vente,
pays_vente
from {{ ref('int_sales') }} as sales
group by 3