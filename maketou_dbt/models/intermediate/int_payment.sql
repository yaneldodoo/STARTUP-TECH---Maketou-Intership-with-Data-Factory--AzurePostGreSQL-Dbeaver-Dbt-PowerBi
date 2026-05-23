SELECT 
    numero_commande,

    COALESCE(montant, 0) AS montantcommande,

    date_paiement,

    COALESCE(statut_paiement, 'unknown') AS statut_paiement,

    COALESCE(devise_paiement, 'unknown') AS devise_paiement,

    COALESCE(erreur_paiement, 'unknown') AS erreur_paiement,

    COALESCE(processeur, 'unknown') AS processeur,

    COALESCE(methode_paiement, 'unknown') AS methode_paiement,

    COALESCE(passerelle_paiement, 'unknown') AS passerelle_paiement,

    COALESCE(zonemondiale, 'unknown') AS zonemondiale


FROM {{ ref('stg_payment') }}