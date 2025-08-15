{{ config(materialized='view') }}

SELECT
    id AS loan_id,
    issue_d AS issue_date,
    revenue,
    dti_n AS dti_ratio,
    loan_amnt AS loan_amount,
    fico_n AS fico_score,
    experience_c AS employment_experience,
    emp_length AS employment_length,
    purpose AS loan_purpose,
    home_ownership_n AS home_ownership,
    addr_state AS borrower_state,
    "Default" AS loan_status_flag
FROM
    {{ source('raw', 'loans_granting') }}