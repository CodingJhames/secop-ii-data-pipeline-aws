terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del proveedor de AWS
provider "aws" {
  region = "us-east-1" # Puedes cambiarla a us-east-2 si prefieres
}

# Creación del Bucket de S3 para los datos del SECOP II
resource "aws_s3_bucket" "secop_data_bucket" {
  # IMPORTANTE: Este nombre debe ser único en TODO EL MUNDO. 
  # Si alguien ya lo usó, cámbialo un poco (ej. agrega tu fecha de nacimiento).
  bucket = "secop-ii-data-jhames-2026" 

  force_destroy = true # Esto permite borrar el bucket incluso si tiene datos (útil para pruebas)
}

# Bloque de salida para saber que todo salió bien
output "s3_bucket_name" {
  value = aws_s3_bucket.secop_data_bucket.bucket
}
