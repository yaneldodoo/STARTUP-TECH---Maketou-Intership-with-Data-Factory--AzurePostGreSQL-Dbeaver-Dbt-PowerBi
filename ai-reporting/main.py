from report import get_data
from ai import generate_report
from google_docs import create_doc

def main():
    print("📊 Extraction data...")
    data = get_data()

    print("🤖 Génération IA...")
    report = generate_report(data)

    print("📄 Envoi vers Google Docs...")
    link = create_doc(report)

    print("✅ DONE")
    print(link)

if __name__ == "__main__":
    main()