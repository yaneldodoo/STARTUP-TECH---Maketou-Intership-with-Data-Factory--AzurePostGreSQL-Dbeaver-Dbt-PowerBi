from openai import OpenAI
from datetime import datetime
import os
from dotenv import load_dotenv

# Charger les variables .env
load_dotenv()

# Client OpenAI (clé dans .env)
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def build_prompt(data: str):
    date_report = datetime.now().strftime("%Y-%m-%d")

    prompt = f"""
Tu es un Data Analyst Senior (niveau Staff / Lead en entreprise tech).

Tu produis un rapport d'exploration de données destiné à des équipes produit et data.

========================
📅 Date du rapport : {date_report}
========================

🎯 OBJECTIF
Tu ne fais PAS un résumé.
Tu fais une EXPLORATION critique des données.

Tu dois faire parler les données et révéler ce qu'on ne t'a pas demandé.

========================
🚨 RÈGLES ABSOLUES
========================

- Langue : FRANÇAIS UNIQUEMENT
- Style : professionnel, analytique, fluide
- INTERDICTION de texte générique ou vague
- Chaque insight doit être soutenu par des CHIFFRES
- Toujours quantifier (%, volumes, ratios, écarts)

========================
💡 MISSION ANALYTIQUE
========================

Tu dois produire :

✔ surprises (résultats inattendus)
✔ anomalies (bugs, incohérences, valeurs suspectes)
✔ patterns cachés (segments, comportements)
✔ hypothèses métier (explications possibles)
✔ questions ouvertes (zones inconnues)
✔ pistes d'amélioration future

========================
📊 EXIGENCES D'ANALYSE
========================

- analyse univariée de chaque table
- segmentation (temps, statut, région, catégories)
- détection de signaux faibles
- comparaison entre groupes
- mise en évidence d'écarts significatifs

========================
🧠 STRUCTURE OBLIGATOIRE
========================

1. Titre du rapport
2. Résumé exécutif (KPIs + insights clés)
3. Analyse par table :
   - Univariée
   - Patterns & segmentation
   - Anomalies
   - Hypothèses métier
   - Questions ouvertes
   - Pistes futures
4. Risques
5. Recommandations

========================
🎨 FORMAT (IMPORTANT)
========================

- Texte propre, style rapport business
- PAS de markdown ### ou ###
- Utilise des titres naturels
- Mets en avant les chiffres (ex:  32% , X nombres, X sur Y, total de)

========================
📦 DONNÉES
========================

{data}

========================
🚀 OBJECTIF FINAL
========================

Rapport prêt pour CEO / Head of Data.
Clair, critique, exploitable.

FORMAT STRICT

Le rapport doit être prêt à être copié dans Google Docs sans retouche.
- Met des titres H1,H2, H3 pour aborder les grands titres
- Aucun emoji
- Aucun symbole décoratif
- Aucun markdown (###, ***, etc.)
- Juste du texte structuré avec des titres naturels
"""

    return prompt


def generate_report(data: str):
    prompt = build_prompt(data)

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {
                "role": "system",
                "content": "Tu es un Data Analyst senior spécialisé en exploration critique de données."
            },
            {
                "role": "user",
                "content": prompt
            }
        ],
        temperature=0.4
    )

    return response.choices[0].message.content