select 
id_vente,
id_acheteur,
id_boutique_vente,
total_montant_vente,
pays_vente,
sourcevente

from {{ ref('int_sales') }}  