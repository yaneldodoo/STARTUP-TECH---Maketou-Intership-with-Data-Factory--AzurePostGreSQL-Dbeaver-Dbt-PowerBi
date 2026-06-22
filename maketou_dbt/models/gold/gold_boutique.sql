-- ce gold est pour voir les boutiques crées et quand elles ont étés créee 

select 
    id,
    created_at,
    pays,
    date_trunc('hour', created_at) as heure,
    date_trunc('month', created_at) as mois,
    date_trunc('day', created_at) as date
from {{ ref('int_boutique') }}