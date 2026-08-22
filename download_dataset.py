import os
import zipfile

from dotenv import load_dotenv
from kaggle.api.kaggle_api_extended import KaggleApi

load_dotenv()

os.environ["KAGGLE_API_TOKEN"] = os.getenv("KAGGLE_API_TOKEN")

api = KaggleApi()
api.authenticate()

# Download
api.competition_download_files(
    "m5-forecasting-accuracy",
    path="data/raw"
)

# Extract
zip_path = "data/raw/m5-forecasting-accuracy.zip"

with zipfile.ZipFile(zip_path, "r") as zip_ref:
    zip_ref.extractall("data/raw")

print("M5 dataset downloaded and extracted successfully.")