/* Check for NULL Values */

SELECT
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_NULLs,
    SUM(CASE WHEN Surname IS NULL THEN 1 ELSE 0 END) AS Surname_NULLs,
    SUM(CASE WHEN Credit_Score IS NULL THEN 1 ELSE 0 END) AS Credit_Score_NULLs,
    SUM(CASE WHEN Geography IS NULL THEN 1 ELSE 0 END) AS Geography_NULLs,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_NULLs,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_NULLs,
    SUM(CASE WHEN Tenure IS NULL THEN 1 ELSE 0 END) AS Tenure_NULLs,
    SUM(CASE WHEN Balance IS NULL THEN 1 ELSE 0 END) AS Balance_NULLs,
    SUM(CASE WHEN Num_Of_Products IS NULL THEN 1 ELSE 0 END) AS Products_NULLs,
    SUM(CASE WHEN Has_Credit_Card IS NULL THEN 1 ELSE 0 END) AS Credit_Card_NULLs,
    SUM(CASE WHEN Is_Active_Member IS NULL THEN 1 ELSE 0 END) AS Active_Member_NULLs,
    SUM(CASE WHEN Estimated_Annual_Salary IS NULL THEN 1 ELSE 0 END) AS Salary_NULLs,
    SUM(CASE WHEN Exited IS NULL THEN 1 ELSE 0 END) AS Exited_NULLs
FROM dbo.Bank_Churn_Clean;

/*
   Validation Result:
   NULL Values: 0 across all 13 columns
   Status: Passed
*/