import requests 
import boto3
import json
from datetime import date 
import time

# configuring
BUCKET_NAME = "ecommerce-pipeline-rawdata"
BASE_URL = "https://dummyjson.com"
TODAY = str(date.today())

#fetching data from API
def fetch_data(url, max_retries=3):
    for attempt in range(max_retries):
        try:
            response = requests.get(url,timeout =10)
            response.raise_for_status()  # Raise an exception for HTTP errors
            return response.json()
        except Exception as e:
            print(f"Attempt {attempt + 1} failed: {e}")
            time.sleep(2)  
    raise Exception(f"Failed to fetch data from {url} after {max_retries} attempts")

#saving to s3
def save_to_s3(data, endpoint_name):
    s3 = boto3.client('s3')
    key =f"raw/{endpoint_name}/{TODAY}/data.json"
    s3.put_object(
        Bucket=BUCKET_NAME, 
        Key=key,
        Body=json.dumps(data)
        )
    print(f"Saved {endpoint_name} to s3://{BUCKET_NAME}/{key}")
    
def fetch_users():
    print("Fetching users...")
    data = fetch_data(f"{BASE_URL}/users?limit=100")
    save_to_s3(data["users"], "users")

def fetch_carts():
    print("Fetching carts...")
    data = fetch_data(f"{BASE_URL}/carts?limit=100")
    save_to_s3(data["carts"], "carts")

def fetch_products():
    print("Fetching products...")
    data = fetch_data(f"{BASE_URL}/products?limit=100")
    save_to_s3(data["products"], "products")

if __name__ == "__main__":
    fetch_users()
    fetch_carts()
    fetch_products()
    print("All data successfully saved to S3!")