
-- ==========================================
-- SALES DATA ANALYSIS PROJECT
-- SQL: MySQL
-- ==========================================

-- 1. Create and select database
CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;

-- 2. Create sales table
CREATE TABLE IF NOT EXISTS sales (
    OrderID INT,
    CustomerID INT,
    Date DATE,
    Product VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    ReferralSource VARCHAR(100)
);

-- 3. Display all records
SELECT *
FROM sales;

-- 4. Filter sales above 1000
SELECT *
FROM sales
WHERE TotalPrice > 1000;

-- 5. Sort sales from highest to lowest
SELECT OrderID, Product, Quantity, TotalPrice
FROM sales
ORDER BY TotalPrice DESC;

-- 6. Count total transaction records
SELECT COUNT(*) AS Total_Transactions
FROM sales;

-- 7. Calculate total revenue
SELECT SUM(TotalPrice) AS Total_Revenue
FROM sales;

-- 8. Calculate average sale value
SELECT AVG(TotalPrice) AS Average_Sale_Value
FROM sales;

-- 9. Product-wise sales analysis
SELECT
    Product,
    SUM(TotalPrice) AS Total_Revenue,
    SUM(Quantity) AS Units_Sold,
    COUNT(*) AS Transaction_Count
FROM sales
GROUP BY Product
ORDER BY Total_Revenue DESC;

-- 10. Payment method analysis
SELECT
    PaymentMethod,
    COUNT(*) AS Transaction_Count,
    SUM(TotalPrice) AS Total_Revenue,
    AVG(TotalPrice) AS Average_Sale
FROM sales
GROUP BY PaymentMethod
ORDER BY Total_Revenue DESC;

-- 11. Completed orders analysis
SELECT
    Product,
    COUNT(*) AS Completed_Transactions,
    SUM(TotalPrice) AS Revenue
FROM sales
WHERE OrderStatus = 'Completed'
GROUP BY Product
ORDER BY Revenue DESC;

-- 12. Monthly sales analysis
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Sales_Month,
    COUNT(*) AS Transaction_Count,
    SUM(TotalPrice) AS Monthly_Revenue,
    AVG(TotalPrice) AS Average_Sale
FROM sales
WHERE Date IS NOT NULL
GROUP BY DATE_FORMAT(Date, '%Y-%m')
ORDER BY Sales_Month;

-- 13. Customer-wise spending
SELECT
    CustomerID,
    COUNT(*) AS Transaction_Count,
    SUM(TotalPrice) AS Total_Spending,
    AVG(TotalPrice) AS Average_Spending
FROM sales
GROUP BY CustomerID
ORDER BY Total_Spending DESC;

-- 14. Referral source analysis
SELECT
    ReferralSource,
    COUNT(*) AS Transaction_Count,
    SUM(TotalPrice) AS Total_Revenue
FROM sales
GROUP BY ReferralSource
ORDER BY Total_Revenue DESC;

-- 15. Quantity-based filtering
SELECT OrderID, Product, Quantity, TotalPrice
FROM sales
WHERE Quantity >= 5
ORDER BY Quantity DESC;

-- ==========================================
-- END OF SALES DATA ANALYSIS PROJECT
-- ==========================================
