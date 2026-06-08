# Ecommerce Analytics Engineering Pipeline

An end-to-end analytics engineering pipeline built to answer key ecommerce business questions.

## Business Questions Answered
- Which products drive the most revenue?
- Which customer segments have the highest lifetime value?
- Which product categories have the highest basket value?

## Tech Stack

| Layer | Tool |
|---|---|
| Ingestion | Python, boto3 |
| Storage | AWS S3 |
| Warehouse | Snowflake |
| Transformation | dbt Core |
| Orchestration | Dagster |
| Visualisation | Power BI |

## Data Models

### Staging
- `stg_users` : cleaned customer profiles
- `stg_carts` : cleaned cart data
- `stg_cart_items` : one row per product per cart
- `stg_products`: cleaned product catalogue

### Intermediate
- `int_user_carts` : users joined with their carts

### Marts
- `mart_customer_ltv` : customer lifetime value by segment
- `mart_product_revenue` : revenue by product
- `mart_category_basket` : basket analysis by category

## Data Quality
13 dbt tests covering:
- Uniqueness constraints
- Not null checks
- Accepted value validation

## Pipeline Orchestration
Dagster orchestrates the full pipeline with a daily schedule running at 6am.

## Dashboard
Power BI dashboard with 5 KPI cards and 3 charts:
- Customer LTV by Age Group
- Top 10 Products by Revenue
- Revenue by Product Category

## Setup
1. Clone the repository
2. Install dependencies: `pip install -r requirements.txt`
3. Configure AWS credentials: `aws configure`
4. Configure Snowflake connection in `~/.dbt/profiles.yml`
5. Run ingestion: `python ingest.py`
6. Run dbt models: `cd ecommerce_dbt && dbt run`
7. Start Dagster: `cd dagster_pipeline && dagster dev -f definitions.py`
