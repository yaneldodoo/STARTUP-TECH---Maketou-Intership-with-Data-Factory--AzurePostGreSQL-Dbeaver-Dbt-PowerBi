select 
 cast("montant" as integer) as montant,
    date_paiement,
    statut_paiement,
    devise_paiement,
    erreur_paiement,
    processeur,
    methode_paiement,
    passerelle_paiement
from {{ ref('stg_payment') }}
