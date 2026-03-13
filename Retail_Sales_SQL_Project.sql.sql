Use RetailSalesDB 
go

SELECT TOP 10 * FROM superstore_sales

-- Data types  
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'superstore_sales'

-- Unnecessary Column Removed
ALTER TABLE superstore_sales
DROP COLUMN Column1


-- NULL Values (key columns)
SELECT *FROM superstore_sales
WHERE Order_ID IS NULL
  OR Customer_ID IS NULL
  OR Product_ID IS NULL
  OR Sales IS NULL


--Duplicate Rows 
SELECT Order_ID, Product_ID, COUNT(*)
FROM superstore_sales
GROUP BY Order_ID, Product_ID
HAVING COUNT(*) > 1

-- Fix
WITH cte AS
(SELECT *,ROW_NUMBER() OVER(PARTITION BY Order_ID, Product_ID
ORDER BY Order_ID) AS rn
FROM superstore_sales
)
DELETE FROM cte
WHERE rn > 1

-- Extra Spaces Remove
UPDATE superstore_sales
SET
Customer_Name = TRIM(Customer_Name),
City = TRIM(City),
State = TRIM(State),
Product_Name = TRIM(Product_Name)

-- Negative sales check.
SELECT * FROM superstore_sales
WHERE Sales < 0

-- Date Format 
SELECT Order_Date FROM superstore_sales

-- Rows count check.
SELECT COUNT(*) FROM superstore_sales

-- Check distinct categories
SELECT DISTINCT Category AS Unique_Categories
FROM superstore_sales

-- Check distinct regions
SELECT DISTINCT Region AS Unique_Regions
FROM superstore_sales



-- Total Sales (KPI)
SELECT SUM(Sales) AS Total_Sales
FROM superstore_sales

-- Sales by Category
SELECT Category, SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Category
ORDER BY Total_Sales DESC

-- Top 10 Products
SELECT TOP 10 Product_Name,
SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Product_Name
ORDER BY Total_Sales DESC

-- Sales by Region
SELECT Region,
SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Region
ORDER BY Total_Sales DESC

-- Top Customers
SELECT TOP 10 Customer_Name,
SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Customer_Name
ORDER BY Total_Sales DESC

-- Monthly Sales Trend
SELECT 
YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Sales) AS Monthly_Sales
FROM superstore_sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month

-- Sales by State
SELECT State, SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY State
ORDER BY Total_Sales DESC

-- Products Based on Sales Performance
SELECT Product_Name,Sales,
CASE
WHEN Sales > 500 THEN 'High Sales'
WHEN Sales BETWEEN 200 AND 500 THEN 'Medium Sales'
ELSE 'Low Sales'
END AS Sales_Level
FROM superstore_sales

-- Sales Performance by Region and Category
SELECT Region, Category, SUM(Sales) AS Total_Sales
FROM superstore_sales
GROUP BY Region, Category
ORDER BY Total_Sales DESC

