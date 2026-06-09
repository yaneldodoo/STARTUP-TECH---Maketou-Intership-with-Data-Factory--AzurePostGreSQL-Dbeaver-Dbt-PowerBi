select 

s.id_vente,
s.id_acheteur,
s.id_boutique_vente,
s.montant_vente,
sum(s.montant_vente) as total_montant_vente,
s.pays_vente,
s.sourcevente ,
st.date_vente

from {{ ref('stg_sales') }}  s 
join {{ ref('stg_sale_timestamp') }}  st on s.id_vente = st.id_vente
group by 1,2,3,4,6,7,8