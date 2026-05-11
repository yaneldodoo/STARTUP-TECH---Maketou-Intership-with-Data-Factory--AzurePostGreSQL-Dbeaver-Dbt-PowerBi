select 
    id,
   created_at,
    pays
from {{ ref('stg_boutique') }}
