import os
from pyspark.sql import SparkSession, functions as F

# --- SET UP ENVIRONMENT VARIABLES FOR WINDOWS ---
# This is crucial for fixing common PySpark errors on Windows.
os.environ["HADOOP_HOME"] = "C:\\hadoop"
os.environ["PATH"] = os.environ["PATH"] + ";C:\\hadoop\\bin"
os.environ["PYSPARK_PYTHON"] = "python.exe"
os.environ["PYSPARK_DRIVER_PYTHON"] = "python.exe"

# --- CREATE SPARK SESSION ---
spark = SparkSession.builder \
    .appName("LoanETLPipeline") \
    .config("spark.jars.packages", "org.postgresql:postgresql:42.6.0") \
    .getOrCreate()

# --- POSTGRESQL CONNECTION PROPERTIES ---
url = "jdbc:postgresql://localhost:5432/lending-club"
properties = {
    "user": "postgres",
    "password": "your_password",
    "driver": "org.postgresql.Driver"
}

# --- EXTRACT (READ FROM POSTGRESQL) ---
# Read the loans_granting table into a PySpark DataFrame
raw_df = spark.read.jdbc(url=url, table="raw.loans_granting", properties=properties)

# --- TRANSFORM (CLEAN AND FEATURE ENGINEER) ---
# Clean and transform the raw data
cleaned_df = raw_df.select(
    F.col("id").alias("loan_id"),
    F.col("issue_d").alias("issue_date"),
    F.col("loan_amnt").alias("loan_amount"),
    F.col("purpose").alias("loan_intent"),
    F.col("addr_state").alias("address_state"),
    F.col("Default").alias("loan_status_flag"),
    F.when(F.col("fico_n") < 580, "Poor")
     .when((F.col("fico_n") >= 580) & (F.col("fico_n") < 670), "Fair")
     .when((F.col("fico_n") >= 670) & (F.col("fico_n") < 740), "Good")
     .when((F.col("fico_n") >= 740) & (F.col("fico_n") < 800), "Very Good")
     .otherwise("Excellent").alias("fico_band")
)

# --- LOAD (WRITE TO POSTGRESQL) ---
# Write the cleaned data to a new staging table
cleaned_df.write.jdbc(
    url=url, 
    table="marts.loans_staging", 
    mode="overwrite", 
    properties=properties
)

# --- STOP SPARK SESSION ---
spark.stop()