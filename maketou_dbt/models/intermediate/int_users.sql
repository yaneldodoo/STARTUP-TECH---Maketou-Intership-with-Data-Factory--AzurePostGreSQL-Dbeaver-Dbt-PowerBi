select 

cast (coalesce(id_utilisateur, 'unknown') as VARCHAR(255)) as id_utilisateur,
date_creation_user,
date_trunc('month', date_creation_user) as mois,
date_trunc('year', date_creation_user) as  annee,  
date_trunc('minute', date_creation_user) as  minute,  
date_trunc('hour', date_creation_user) as  heure,  
date_trunc('day', date_creation_user) as  jour,  
cast (coalesce(activation_2fa, 'unknown') as VARCHAR(255)) as activation_2fa,
cast (coalesce(methode_2fa, 'unknown') as VARCHAR(255)) as methode_2fa

from {{ ref('stg_users') }}