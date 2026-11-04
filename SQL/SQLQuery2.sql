/* 2. Verify Customer_ID Uniqueness */

  SELECT COUNT(*) AS Total_Records,
         COUNT(DISTINCT Customer_ID) AS Unique_Customers
  FROM dbo.Bank_Churn_Clean;

/*
   Validation Result:
   Total Records: 10,000
   Unique Customers: 10,000
   Status: Passed
*/