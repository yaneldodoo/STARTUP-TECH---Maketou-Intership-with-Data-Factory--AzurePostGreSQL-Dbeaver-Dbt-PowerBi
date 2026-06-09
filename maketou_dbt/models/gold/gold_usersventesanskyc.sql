-- ce gold est pour voir les users ayant des boutiques avec ventes + statut KYC

with sales_stores as (

    select distinct
        id_boutique_vente
    from {{ ref('int_sales') }}

),

users_with_sales as (

    select distinct
        sa.id_utilisateur_acces
    from {{ ref('int_store_access') }} sa
    join sales_stores s
        on sa.id_boutique_acces = s.id_boutique_vente

),

kyc_status as (

    select
        id_utilisateur,
        is_validated,
        is_refused,
        is_pending,
        is_cancelled
    from {{ ref('int_kyc') }}

)

select

    u.id_utilisateur_acces,

    case 
        when coalesce(k.is_validated, 0) = 1 then 'kyc_validé'
        when k.id_utilisateur is null then 'no_kyc'
        else 'kyc_non_validé'
    end as kyc_group

from users_with_sales u

left join kyc_status k
    on u.id_utilisateur_acces = k.id_utilisateur