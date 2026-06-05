from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
import os
import pickle
import webbrowser

SCOPES = [
    "https://www.googleapis.com/auth/documents",
    "https://www.googleapis.com/auth/drive.file"
]

def get_creds():
    creds = None

    if os.path.exists("token.pickle"):
        with open("token.pickle", "rb") as token:
            creds = pickle.load(token)

    if not creds or not creds.valid:
        flow = InstalledAppFlow.from_client_secrets_file(
            "credentials_oauth.json",
            SCOPES
        )
        creds = flow.run_local_server(port=0)

        with open("token.pickle", "wb") as token:
            pickle.dump(creds, token)

    return creds


def create_doc(text):
    creds = get_creds()

    docs = build("docs", "v1", credentials=creds)

    # 1. création du doc
    doc = docs.documents().create(body={
        "title": "Weekly AI Report"
    }).execute()

    doc_id = doc["documentId"]

    # 2. insertion du texte
    docs.documents().batchUpdate(
        documentId=doc_id,
        body={
            "requests": [
                {
                    "insertText": {
                        "location": {"index": 1},
                        "text": text
                    }
                }
            ]
        }
    ).execute()

    # 3. lien final
    link = f"https://docs.google.com/document/d/{doc_id}"

    # 🔥 OUVERTURE AUTOMATIQUE DANS LE NAVIGATEUR
    webbrowser.open(link)

    return link 