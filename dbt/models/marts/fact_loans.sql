{{ config(materialized='table') }}

WITH stg_loans_cleaned AS (

    SELECT * FROM {{ ref('stg_loans') }}

)

SELECT
    loan_id,
    issue_date,
    loan_amount,
    loan_purpose,
    borrower_state,
    CASE
        WHEN loan_status_flag = 1 THEN 'Default'
        ELSE 'Paid'
    END AS loan_status,
    CASE
        WHEN fico_score IS NULL THEN 'Unknown'
        WHEN fico_score < 580 THEN 'Poor'
        WHEN fico_score < 670 THEN 'Fair'
        WHEN fico_score < 740 THEN 'Good'
        WHEN fico_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS fico_band
FROM
    stg_loans_cleaned