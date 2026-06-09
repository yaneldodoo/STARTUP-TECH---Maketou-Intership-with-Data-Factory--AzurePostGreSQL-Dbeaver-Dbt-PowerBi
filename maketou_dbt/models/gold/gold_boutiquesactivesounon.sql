-- ce gold regarde les boutiques actives ou non en se basant sur la récente  vente faite 
-- derniere exportation 27 avril 2026 à 15h29

SELECT
    id_boutique_vente,

    MAX(date_vente) AS last_sale_date,

    CASE 
        WHEN MAX(date_vente) >= DATE '2026-03-01'
        THEN 'active'
        ELSE 'inactive'
    END AS boutique_status

FROM {{ ref('int_sales') }}

GROUP BY id_boutique_vente