-- Create schemas for raw and analytics data
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS marts;

-- Create the raw data table to hold the initial CSV import
CREATE TABLE raw.loans_granting (
    id BIGINT,
    issue_d DATE,
    revenue NUMERIC,
    dti_n NUMERIC,
    loan_amnt NUMERIC,
    fico_n NUMERIC,
    experience_c VARCHAR(50),
    emp_length VARCHAR(20),
    purpose TEXT,
    home_ownership_n VARCHAR(20),
    addr_state VARCHAR(5),
    zip_code VARCHAR(10),
    "Default" INTEGER,
    title TEXT,
    "desc" TEXT
);

-- Create the fact table for analytics
CREATE TABLE marts.fact_loans (
    loan_id BIGINT PRIMARY KEY,
    issue_date DATE,
    loan_amount NUMERIC,
    loan_intent VARCHAR(50),
    fico_band VARCHAR(20),
    dti_ratio NUMERIC,
    risk_flag VARCHAR(20),
    address_state VARCHAR(5)
);

-- Create a dimension table for borrower demographics
CREATE TABLE marts.dim_borrower (
    borrower_id SERIAL PRIMARY KEY,
    experience_category VARCHAR(50),
    employment_length VARCHAR(20),
    home_ownership VARCHAR(20)
);