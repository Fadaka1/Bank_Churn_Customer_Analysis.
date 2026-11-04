/* Validate Binary Columns */

SELECT
    SUM(CASE WHEN Has_Credit_Card NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Credit_Card_Values,
    SUM(CASE WHEN Is_Active_Member NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Active_Member_Values,
    SUM(CASE WHEN Exited NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Exited_Values
FROM dbo.Bank_Churn_Clean;

/*
   Validation Result:
   Invalid Has_Credit_Card Values: 0
   Invalid Is_Active_Member Values: 0
   Invalid Exited Values: 0
   Status: Passed
*/