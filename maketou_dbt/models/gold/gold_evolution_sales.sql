-- ce gold est fait pour l'évolution des ventes par mois et année

select 
date_trunc('month', date_vente) as mois,
date_trunc('year', date_vente) as année,
date_vente,
total_montant_vente

from {{ ref('int_sales') }}  