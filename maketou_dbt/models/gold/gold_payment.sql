-- ce gold est fait pour trier les paiements, leurs nombres en fonction des mois et années, le processeur, la méthode de paiement, le statut de paiement et l'erreur de paiement

SELECT 

    date_trunc('month', date_paiement) AS mois,
    date_trunc('year', date_paiement) AS annee,

    processeur,
    methode_paiement,
    statut_paiement,
    erreur_paiement,

    COUNT(*) AS nb_paiements,
    SUM(montantcommande) AS ca_total,

    COUNT(*) FILTER (WHERE statut_paiement = 'failed') AS nb_echecs,
    COUNT(*) FILTER (WHERE statut_paiement = 'completed') AS nb_success,
    COUNT(*) FILTER (WHERE statut_paiement = 'pending') AS nb_encours

FROM {{ ref('int_payment') }}

GROUP BY 1,2,3,4,5,6