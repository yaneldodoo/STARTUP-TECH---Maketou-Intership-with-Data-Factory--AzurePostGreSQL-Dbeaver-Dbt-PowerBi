# Defis rencontrés

## Donneés sales

J'ai eu beaucoup de difficultés pour l'ingestion de la table payment et panier. Elle était très sale, differents separateurs.
Decouverte de quotechar pour protégrer les virgules; Id en integrer or qu'il était mélangé de chiffre et lettre donc utiliser replace pour transofmrer en numeric

## Date à normaliser
Les dates etaient en language humain : novembre, etc et il fallait de 1 les traduire en anglais pour aider le language sql, elle contenait ausssi les heures et les decallages horaire, il fallait donc scinder un à un.


## dbt
Compatible avec Python 3.11 donc il fallait tout briser et installer le bon python, init.


