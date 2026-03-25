# SECOP II Data Pipeline: Colombian Public Procurement 2026

## Project Overview
This project is an end-to-end Data Engineering pipeline designed to ingest, store, and transform public procurement data from Colombia's **SECOP II** portal. As part of the **Data Engineering Zoomcamp**, this pipeline demonstrates modern cloud infrastructure (IaC) and efficient data ingestion techniques.

The goal is to analyze public spending transparency for the 2026 fiscal year, bridging the gap between **Legal Tech** and **Data Engineering**.

## Architecture & Technologies
- **Infrastructure as Code (IaC):** [Terraform](https://www.terraform.io/) to manage AWS resources.
- **Cloud Storage:** [AWS S3](https://aws.amazon.com/s3/) (Medallion architecture - starting with the `raw/` layer).
- **Orchestration & Ingestion:** [Python](https://www.python.org/) (Sodapy for API connection, Boto3 for AWS integration).
- **Data Formatting:** Optimized **Parquet** for storage and cost efficiency.
- **Environment:** James-T-850 (Ubuntu/Linux).

## Project Structure

    secop-ii-aws/
    ├── terraform/          # AWS S3 bucket and infra definitions
    ├── scripts/            # Python ingestion scripts (Socrata API to S3)
    ├── dbt/                # Transformations (In progress)
    ├── docker/             # Containerization files (In progress)
    └── .gitignore          # Security: Ignoring venv and secrets

## How it works
- **Infrastructure:** Terraform initializes the AWS provider and creates a globally unique S3 bucket to host the data lake.
- **Ingestion:** A Python script connects to the Datos Abiertos Colombia API, extracts current 2026 contract records, converts them into a Pandas DataFrame, and uploads them to S3 in Parquet format.
- **Storage:** The data is partitioned and stored in the `raw/` folder within S3, ready for downstream processing.

## Current Milestones
- [x] Cloud Infrastructure deployment with Terraform.
- [x] Successful ingestion of 100,000 records from SECOP II.
- [x] Secure authentication flow with GitHub and AWS.
- [ ] Transformation layer with dbt (Upcoming).
- [ ] Dashboard visualization (Upcoming).

## Why this project?
Coming from a legal background, I am reinventing my career by combining my knowledge of administrative law with advanced data engineering. This project aims to provide a scalable tool for auditing public contracts efficiently.