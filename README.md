# Bank_Churn_Customer_Analysis.


## Project Overview.

The **Bank Churn Customer Analysis** project examines customer churn patterns using a dataset of 10,000 bank customers. The analysis focuses on identifying customer segments with higher churn rates and examining how geography, gender, age, credit score, tenure, account balance, number of products, and active membership relate to customer churn.

The project follows a structured data analytics workflow:

**Excel → SQL Server Management Studio (SSMS) → Power BI**

Excel was used for initial data preparation and adjustments. SQL Server Management Studio (SSMS) was used to validate the dataset through checks for duplicate records, Customer ID uniqueness, NULL values, categorical and binary values, and unusual numerical values. Within Power BI, Power Query was used for data transformation and manipulation, including creating categorical groups for analysis. DAX was used to develop measures, while Power BI visualizations were used to analyze customer churn patterns and build an interactive dashboard.

The dataset contains **10,000 unique customers**, of which **2,037 have churned**, representing an overall churn rate of **20.37%**.

The objective is to identify customer segments associated with higher churn rates and present data-driven findings that can inform customer retention strategies.

##  Business Problem.

Customer churn refers to the loss of customers who discontinue their relationship with a business or stop using its products and services. In the banking sector, this occurs when customers leave a bank and end their banking relationship. Customer churn is a concern for banks because the loss of existing customers can affect customer retention, revenue and long-term business growth.

Understanding customer churn patterns is therefore important for identifying customer segments with higher rates of customer loss and determining where retention efforts may require greater attention.

This project examines the bank's customer data to identify patterns in churn across different customer characteristics and provide insights that can inform customer retention strategies.

The analysis seeks to answer the following business questions:

- What is the overall customer churn rate?
- Which geographical regions have higher churn rates?
- How do churn rates differ by gender and age group?
- How does the number of products held relate to customer churn?
- How does active membership relate to customer churn?
- How does credit score, account balance and customer tenure relate to churn?

##  Data Source and Dataset.

### Data Source.

The dataset used for this project was obtained from the **Maven Analytics Data Playground**, under the *Bank Customer Churn* dataset. It contains customer account information from a European bank and is meant for data analysis and learning purposes.

Maven Analytics identifies Kaggle as the dataset's original source and lists the licence as Public Domain.

**Dataset source:** [Maven Analytics – Bank Customer Churn](https://mavenanalytics.io/data-playground/bank-customer-churn)

### Dataset Description.

The dataset contains **10,000 customer records and 13 columns**, with each row representing an individual bank customer. It includes demographic, financial and account-related information, alongside a field indicating whether the customer left the bank.

The `Exited` column serves as the target variable for the churn analysis:
- `1` = Customer exited the bank.
- `0` = Customer remained with the bank.

### Original Dataset

The screenshot below shows the original dataset before data preparation and validation.

![Original Bank Customer Churn Dataset](Images/Original%20Bank%20Churn%20Dataset.png)

##  Tools Used

The following tools were used throughout the project:

- **Microsoft Excel:** Used for initial data preparation and adjustments.
- **SQL Server Management Studio (SSMS):** Used to validate the dataset through duplicate checks, NULL checks, Customer_ID verification and other data-quality checks.
- **Power BI:** Used for data analysis, DAX calculations, visualisations and interactive dashboard development.
- **Power Query:** Used within Power BI for data transformation and manipulation, including the creation of categorical groups and sorting columns.
- **GitHub:** Used to document and present the project as part of a data analytics portfolio.

##  Data Preparation and Validation

Data preparation and validation were carried out using Microsoft Excel, SQL Server Management Studio (SSMS), and Power Query within Power BI. Each tool served a specific purpose in preparing the dataset for analysis.

###  Excel Data Preparation

Microsoft Excel was used for initial data preparation and adjustments before importing the dataset into SQL Server.

The prepared dataset is shown below:

![Prepared Bank Churn Dataset](Image/Prepared%20Bank%20Churn%20Data.png)

###  SQL Server Data Validation

SQL Server Management Studio (SSMS) was used to validate the imported dataset and assess its data quality.

The validation checks included:

- Checking for duplicate records.

```sql
SELECT DISTINCT *
INTO dbo.Bank_Churn_Clean
FROM dbo.Bank_Churn_Data$;
```

This query created the cleaned table, dbo.Bank_Churn_Clean, by removing duplicate records from the original imported table, reducing the dataset from 21,881 rows to 10,000 unique customer records.


- Verifying the uniqueness of Customer_ID values.

```sql
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM dbo.Bank_Churn_Clean;
```

Results:
- Total Records: 10,000
- Unique Customers: 10,000

This confirmed that every customer ID in the cleaned table was unique.


- Checking for NULL values across the dataset.

```sql
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
```

Result: All 13 columns returned 0 NULL values.


- Examining categorical and binary values for consistency.

```sql
SELECT
    Geography,
    COUNT(*) AS Customer_Count
FROM dbo.Bank_Churn_Clean
GROUP BY Geography
ORDER BY Geography;
```

```sql
SELECT
    Gender,
    COUNT(*) AS Customer_Count
FROM dbo.Bank_Churn_Clean
GROUP BY Gender
ORDER BY Gender;
```

```sql
SELECT
    SUM(CASE WHEN Has_Credit_Card NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Credit_Card_Values,
    SUM(CASE WHEN Is_Active_Member NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Active_Member_Values,
    SUM(CASE WHEN Exited NOT IN (0, 1) THEN 1 ELSE 0 END) AS Invalid_Exited_Values
FROM dbo.Bank_Churn_Clean;
```

Result: All three columns returned 0 invalid values.


- Reviewing unusual numerical values, including salary values below $1,000 and customers with zero account balances.

```sql
SELECT
    COUNT(*) AS Salary_Values_Below_1000
FROM dbo.Bank_Churn_Clean
WHERE Estimated_Annual_Salary < 1000;
```

Result: 59 records.

```sql
SELECT
    COUNT(*) AS Customers_With_Zero_Balance
FROM dbo.Bank_Churn_Clean
WHERE Balance = 0;
```

Result: 3,617 records.

Both groups were reviewed and retained because I found no evidence that the values were incorrect.


- Identifying surname records containing question marks.

```sql
SELECT
    COUNT(*) AS Surnames_With_Question_Marks
FROM dbo.Bank_Churn_Clean
WHERE Surname LIKE '%?%';
```

Result: 92 records across seven surname patterns.


**Findings:** The query identified 92 customer records across seven surname patterns: H? (19), Hs? (15), L? (14), Y? (13), Y?an (13), K? (11), and Hs?eh (7).

The records were retained because the original surname characters could not be reliably recovered. Deleting them would have reduced the dataset from 10,000 to 9,908 records and resulted in the loss of otherwise usable customer information. Retaining them helped preserve data completeness and avoid unnecessary data loss.

The validation process helped assess the dataset's consistency and identify unusual values requiring review. Records were retained where there was insufficient evidence to classify the values as errors.

###  Power Query Data Transformation

Power Query was used within Power BI to transform and manipulate the data for analysis.

The transformations included creating categorical groups for:

- Age Group
- Credit Score Group
- Salary Group
- Tenure Group
- Balance Group
- Product Count Category

Additional sorting columns were created to maintain the correct order of these grouped categories in the Power BI visualisations.

Find the Power query advanced editor below:

![Power Query Advanced Editor](Images/Power_Query_Advanced_Editor.png.png)

