select 

cast (coalesce(id_utilisateur, 'unknown') as VARCHAR(255)) as id_utilisateur,
date_creation_user,
jour,
heure, 
annee,
mois,
minute,
cast (coalesce(activation_2fa, 'unknown') as VARCHAR(255)) as activation_2fa,
cast (coalesce(methode_2fa, 'unknown') as VARCHAR(255)) as methode_2fa

from {{ ref('int_users') }}