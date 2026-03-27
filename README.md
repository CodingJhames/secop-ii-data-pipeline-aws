# 🏛️ SECOP II Data Pipeline: Colombian Public Procurement 2026

## 📌 Project Overview & Problem Statement
Public procurement transparency is a critical issue. The SECOP II dataset contains millions of records detailing public contracts in Colombia. Analyzing this raw data directly is inefficient and computationally expensive. 

This project is an end-to-end Data Engineering pipeline designed to ingest, store, transform, and visualize public procurement data for the 2026 fiscal year. Created as the final project for the **Data Engineering Zoomcamp**, this pipeline bridges the gap between **Legal Tech** and **Data Engineering**, providing a scalable tool to audit public spending efficiently and identify which government entities manage the highest volume of contracts and their geographical distribution.

## ⚖️ Why this project?
Coming from a legal background, I am reinventing my career by combining my knowledge of administrative law with advanced data engineering. This project demonstrates how modern cloud infrastructure can be leveraged to create practical, transparent auditing tools for public contracts.

## 📊 The Final Dashboard
The culmination of this pipeline is an executive dashboard providing a clear overview of the procurement landscape.
👉 **[View the SECOP II Audit Dashboard Here](https://lookerstudio.google.com/reporting/4b5c34e2-c625-47b2-a394-f332c44ed6ef)** *(Powered by Looker Studio & Google Sheets bridge)*

## 🏗️ Architecture & Technologies
The pipeline is fully cloud-based, utilizing Infrastructure as Code (IaC) and modern data stack tools:

- **Infrastructure as Code (IaC):** [Terraform](https://www.terraform.io/) to manage AWS resources.
- **Orchestration & Ingestion:** [Python](https://www.python.org/) (Sodapy for Socrata API connection, Boto3 for AWS integration).
- **Data Lake (Cloud Storage):** [AWS S3](https://aws.amazon.com/s3/) using a Medallion architecture (starting with the `raw/` layer). Data is stored in optimized **Parquet** format.
- **Data Catalog:** [AWS Glue](https://aws.amazon.com/glue/) Crawlers automatically map the schema of the raw files in S3.
- **Data Warehouse:** [Amazon Athena](https://aws.amazon.com/athena/) (Serverless interactive query service).
- **Data Transformation:** [dbt (Data Build Tool)](https://www.getdbt.com/) connecting to Athena to materialize staging views and analytical fact tables.
- **Environment:** James-T-850 (Ubuntu/Linux).

## ⚙️ How it works (The Pipeline)
1. **Infrastructure Provisioning:** Terraform initializes the AWS provider and creates a globally unique S3 bucket to host the data lake.
2. **Data Extraction:** A Python script connects to the *Datos Abiertos Colombia API*, extracts 100,000 current 2026 contract records, converts them into a Pandas DataFrame, and uploads them to S3 in Parquet format.
3. **Cataloging:** AWS Glue crawls the S3 bucket and creates a table definition in the `secop_db` database.
4. **Transformation:** dbt core runs locally, taking the raw data from Athena, cleaning it in the staging layer, and materializing the final aggregation (e.g., `fct_top_entities_processes`) back into Athena.
5. **Visualization:** Looker Studio connects to the aggregated data to provide an interactive visual audit.

## 📁 Project Structure

    secop-ii-aws/
    ├── terraform/          # AWS S3 bucket and IaC infra definitions
    ├── scripts/            # Python ingestion scripts (Socrata API to S3)
    ├── dbt/                # SQL Transformations (Staging and Marts)
    ├── docker/             # Containerization files
    └── .gitignore          # Security: Ignoring venv and secrets

## ✅ Project Milestones (Completed)
- [x] Cloud Infrastructure deployment with Terraform.
- [x] Successful API ingestion of 100,000 records from SECOP II (Parquet to S3).
- [x] Secure authentication flow with GitHub and AWS.
- [x] Data Cataloging with AWS Glue and Athena integration.
- [x] Transformation layer implemented with dbt (Models & Materializations).
- [x] Executive Dashboard visualization deployed.

## 🚀 Reproducibility (How to run this project)

### 1. AWS Setup & Ingestion
* Run `terraform init` and `terraform apply` in the `/terraform` directory to provision the S3 bucket.
* Execute the Python script in `/scripts` to fetch data from the API and upload it to your S3 bucket.
* Create an AWS Glue Crawler pointing to your S3 `raw/` path to create the database (`secop_db`).

### 2. dbt Setup
* Set up a Python virtual environment and install dependencies: `pip install dbt-athena-community`.
* Configure your `profiles.yml` with your AWS credentials, specifying the `us-east-1` region and the S3 staging directory for Athena query results.

### 3. Run Transformations
Execute the following commands in the dbt project root:
```bash
# Run staging models (creates views in Athena)
dbt run --select staging

# Run analytical models (creates fact tables in Athena)
dbt run --select marts