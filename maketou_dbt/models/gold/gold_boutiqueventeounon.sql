-- ce gold est pour voir les boutiques actives ou non + montant ventes + statut KYC users

with sales_per_store as (
    select
        id_boutique_vente,
        sum(montant_vente) as montant_total
    from {{ ref('int_sales') }}
    group by id_boutique_vente
),

store_users as (
    select distinct
        sa.id_boutique_acces as id_boutique,
        sa.id_utilisateur_acces as id_user
    from {{ ref('int_store_access') }} sa
),

kyc_status as (
    select
        id_utilisateur,
        is_validated
    from {{ ref('int_kyc') }}
),

store_kyc as (
    select
        su.id_boutique,
        case 
            when bool_or(coalesce(k.is_validated,0)=1) then 'kyc_validé'
            when count(k.id_utilisateur)=0 then 'no_kyc'
            else 'kyc_non_validé'
        end as kyc_status
    from store_users su
    left join kyc_status k
        on su.id_user = k.id_utilisateur
    group by su.id_boutique
)

select
    sp.id_boutique_vente as id_boutique,
    sp.montant_total,
    sk.kyc_status

from sales_per_store sp
left join store_kyc sk
    on sp.id_boutique_vente = sk.id_boutique