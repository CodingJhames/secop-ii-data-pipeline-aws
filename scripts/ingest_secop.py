import pandas as pd
from sodapy import Socrata
import boto3
from io import BytesIO

# Configuración del "Caso"
DATASET_ID = "p6dx-8zbt" # ID del SECOP II
BUCKET_NAME = "secop-ii-data-jhames-2026"
FILE_NAME = "raw/secop_ii_2026_sample.parquet"

def ingest_data():
    print("🎬 Iniciando extracción de evidencias (API Socrata)...")
    client = Socrata("www.datos.gov.co", None) # None si no tienes App Token aún
    
    # Pedimos solo los primeros 100,000 registros para ser prácticos hoy
    results = client.get(DATASET_ID, limit=100000)
    df = pd.DataFrame.from_records(results)
    
    print(f"✅ Se han recolectado {len(df)} registros.")

    # Convertir a Parquet (ahorra espacio y dinero en AWS)
    buffer = BytesIO()
    df.to_parquet(buffer, index=False)
    
    # Subir al Archivo Central (S3)
    print("🚀 Subiendo evidencias al estrado de AWS S3...")
    s3 = boto3.client('s3')
    s3.put_object(Bucket=BUCKET_NAME, Key=FILE_NAME, Body=buffer.getvalue())
    
    print(f"🏁 ¡Proceso completado! Archivo guardado como: {FILE_NAME}")

if __name__ == "__main__":
    ingest_data()
