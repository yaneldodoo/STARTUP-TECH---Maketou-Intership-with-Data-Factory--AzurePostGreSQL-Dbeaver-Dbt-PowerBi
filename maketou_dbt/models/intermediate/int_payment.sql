select 
 coalesce(cast("montant" as integer), 0) as montantcommande,
    date_paiement,
    coalesce(statut_paiement, 'unknown') as statut_paiement,
    coalesce(devise_paiement, 'unknown') as devise_paiement,
    coalesce(erreur_paiement, 'unknown') as erreur_paiement,
    coalesce(processeur, 'unknown') as processeur,
    coalesce(methode_paiement, 'unknown') as methode_paiement,
    coalesce(passerelle_paiement, 'unknown') as passerelle_paiement
from {{ ref('stg_payment') }}
