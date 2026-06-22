-- ce gold est pour voir l'arbre de ventes,tracer un treemap afin de voir les plus grosses boutiques, leurs pays phares, les ventes les plus elevés 

select 
id_vente,
id_acheteur,
id_boutique_vente,
total_montant_vente,
pays_vente,
sourcevente

from {{ ref('int_sales') }}  