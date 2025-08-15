-- Count the total number of records
SELECT COUNT(*) AS total_loans FROM raw.loans_granting;

-- Check the distribution of loan purposes
SELECT
    purpose,
    COUNT(*) AS count
FROM raw.loans_granting
GROUP BY purpose
ORDER BY count DESC;

-- Calculate the average loan amount
SELECT
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount
FROM raw.loans_granting;

-- Find the top 10 states with the most loans
SELECT
    addr_state,
    COUNT(*) AS loan_count
FROM raw.loans_granting
GROUP BY addr_state
ORDER BY loan_count DESC
LIMIT 10;

-- Calculate default rate by home ownership type
SELECT
    home_ownership_n,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN "Default" = 1 THEN 1 ELSE 0 END) AS default_count,
    ROUND(100.0 * SUM(CASE WHEN "Default" = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_percent
FROM raw.loans_granting
GROUP BY home_ownership_n
ORDER BY default_rate_percent DESC;