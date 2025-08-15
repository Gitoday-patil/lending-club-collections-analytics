#  Lending Club Loan Collections & Recovery Analytics

## 📌 Project Overview
This project demonstrates an **end-to-end data analytics pipeline** focused on **loan collections and risk analytics** within the banking domain.  
The goal is to build a robust system that transforms raw Lending Club loan data into **actionable business intelligence**.  

The pipeline showcases skills in:
- Data Engineering
- Data Warehousing
- Business Intelligence

Highly relevant for a **Data Analyst role at Barclays**.

---

## 🛠 Problem Statement
The primary challenge for a bank's collections and recovery department is to identify **high-risk loans** and **optimize recovery efforts**.

**Key Business Questions:**
- What is the overall loan default rate?
- How do different borrower demographics (e.g., FICO score, employment) influence loan outcomes?
- What are the key drivers of loan defaults?

---

## 💻 Technology Stack
- **Database:** PostgreSQL  
- **Data Processing:** Python, PySpark  
- **Data Transformation & Modeling:** dbt (Data Build Tool)  
- **Visualization:** Power BI  
- **Version Control:** Git, GitHub  
- **Automation:** Unix Shell Scripting  

---

## 🏗 Project Workflow & Architecture
This project follows a **standard Extract-Load-Transform (ELT) architecture**.

### **1. Data Ingestion (EL)**
- Raw loan data loaded from CSV into a `raw` schema in PostgreSQL.

### **2. Data Transformation (T)**
- **PySpark script** cleans raw data & performs feature engineering.

### **3. Data Modeling (T)**
- **dbt** orchestrates transformations into a **star-schema** model.

### **4. Analysis & Reporting**
- Power BI connects to final dbt-built tables for **interactive dashboards**.

---

## 🚀 How to Set Up & Run the Project

1. Database Setup & Data Ingestion
   Ensure PostgreSQL is installed
   Run:
   psql -U your_username -d your_database -f sql/create_tables.sql
   Import data via pgAdmin or psql

2. Run the ETL Pipeline
   cd pyspark
   python etl_pipeline.py

3. Build Data Models with dbt
   cd dbt
   dbt run
   # Optional: Generate docs & run tests
   dbt docs generate
   dbt docs serve
   dbt test

4. Connect to Power BI
   Open Power BI Desktop
   Get data → PostgreSQL Database
   Select marts.fact_loans table
   Build dashboard visualizations

## 📂 File & Directory Structure
<img width="1918" height="443" alt="file_structure" src="https://github.com/user-attachments/assets/fe78323f-6ce2-417b-ac4d-e58a6747fd60" />

        


## 👤 About the Author
- Gitoday Patil
- LinkedIn: [https://www.linkedin.com/in/gitoday-patil/]
- Email: [gitoday.patil3972@gmail.com]
- Feel free to connect and ask questions about the project!
