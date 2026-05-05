select 
    id,
   created_at,
    monnaie,
from {{ ref('stg_boutique') }}
