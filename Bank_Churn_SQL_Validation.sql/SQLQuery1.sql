USE Bank_Churn;
GO

/* ==========================================
   BANK CHURN DATA VALIDATION
   Project: Bank Churn Customer Analysis
   ========================================== */

/* 1. Verify total number of records */

SELECT COUNT(*) AS Total_Records
FROM dbo.Bank_Churn_Clean;

/*
   Validation Result:
   Total Records: 10,000
   Status: Passed
*/