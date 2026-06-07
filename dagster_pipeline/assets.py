import requests
import boto3
import json
from datetime import date
from dagster import asset

# configuration
BUCKET_NAME = "ecommerce-pipeline-rawdata"
BASE_URL = "https://dummyjson.com"
TODAY = str(date.today())

# function to fetch data from API
def fetch_data(url, max_retries=3):
    import time
    for attempt in range(max_retries):
        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            print(f"Attempt {attempt + 1} failed: {e}")
            time.sleep(2)
    raise Exception(f"Failed to fetch data from {url} after {max_retries} attempts")

# function to save data to S3
def save_to_s3(data, endpoint_name):
    s3 = boto3.client("s3")
    key = f"raw/{endpoint_name}/{TODAY}/data.json"
    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=key,
        Body=json.dumps(data)
    )
    print(f"Saved {endpoint_name} to s3://{BUCKET_NAME}/{key}")

# asset 1 - ingest users
@asset
def ingest_users():
    """Fetch users from DummyJSON API and save to S3"""
    print("Fetching users...")
    data = fetch_data(f"{BASE_URL}/users?limit=100")
    save_to_s3(data["users"], "users")
    return {"status": "success", "records": len(data["users"])}

# asset 2 - ingest carts
@asset
def ingest_carts():
    """Fetch carts from DummyJSON API and save to S3"""
    print("Fetching carts...")
    data = fetch_data(f"{BASE_URL}/carts?limit=100")
    save_to_s3(data["carts"], "carts")
    return {"status": "success", "records": len(data["carts"])}

# asset 3 - ingest products
@asset
def ingest_products():
    """Fetch products from DummyJSON API and save to S3"""
    print("Fetching products...")
    data = fetch_data(f"{BASE_URL}/products?limit=100")
    save_to_s3(data["products"], "products")
    return {"status": "success", "records": len(data["products"])}