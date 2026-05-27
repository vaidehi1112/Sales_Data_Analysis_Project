-- Aggregate Metrics with Window Functions
SELECT 
    TransactionID,
    TransactionAmount,
    SUM(TransactionAmount) OVER() AS TotalSales,
    AVG(TransactionAmount) OVER() AS AvgSalesPerTransaction,
    SUM(Quantity) OVER() AS TotalQuantitySold,
    SUM(TransactionAmount * DiscountPercent / 100) OVER() AS TotalDiscountsGiven,
    SUM(TransactionAmount - TransactionAmount * DiscountPercent / 100) OVER() AS TotalRevenueAfterDiscount
FROM sales_data;

-- Top 5 Cities by Sales
WITH CitySales AS (
    SELECT 
        City, 
        SUM(TransactionAmount) AS TotalSales
    FROM sales_data
    GROUP BY City
)
SELECT City, TotalSales
FROM CitySales
ORDER BY TotalSales DESC
LIMIT 5;

-- Sales by Product and Region using Window Functions
SELECT 
    ProductName, 
    Region, 
    SUM(TransactionAmount) AS SalesByProductRegion,
    ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(TransactionAmount) DESC) AS RegionRank
FROM sales_data
GROUP BY ProductName, Region
ORDER BY Region, SalesByProductRegion DESC;

-- Monthly Sales and Growth Rate
WITH MonthlySales AS (
    SELECT 
        DATE_TRUNC('month', TransactionDate) AS Month,
        SUM(TransactionAmount) AS TotalSales
    FROM sales_data
    GROUP BY DATE_TRUNC('month', TransactionDate)
)
SELECT 
    Month,
    TotalSales,
    LAG(TotalSales) OVER(ORDER BY Month) AS PreviousMonthSales,
    (TotalSales - LAG(TotalSales) OVER(ORDER BY Month)) / LAG(TotalSales) OVER(ORDER BY Month) * 100 AS SalesGrowthRate
FROM MonthlySales;

-- Customer Segmentation by Age Group
WITH AgeGroups AS (
    SELECT 
        CASE 
            WHEN CustomerAge BETWEEN 20 AND 30 THEN '20-30'
            WHEN CustomerAge BETWEEN 31 AND 40 THEN '31-40'
            WHEN CustomerAge BETWEEN 41 AND 50 THEN '41-50'
            WHEN CustomerAge BETWEEN 51 AND 60 THEN '51-60'
            ELSE '60+'
        END AS AgeGroup,
        SUM(TransactionAmount) AS TotalSales
    FROM sales_data
    GROUP BY AgeGroup
)
SELECT 
    AgeGroup, 
    TotalSales,
    RANK() OVER(ORDER BY TotalSales DESC) AS SalesRank
FROM AgeGroups;

-- Average Delivery Time by City with CTE
WITH CityDeliveryTime AS (
    SELECT 
        City, 
        AVG(DeliveryTimeDays) AS AvgDeliveryTime
    FROM sales_data
    GROUP BY City
)
SELECT 
    City, 
    AvgDeliveryTime
FROM CityDeliveryTime
ORDER BY AvgDeliveryTime;

-- Top 5 Customers by Total Spend
SELECT 
    CustomerID,
    SUM(TransactionAmount) AS TotalSpend,
    RANK() OVER(ORDER BY SUM(TransactionAmount) DESC) AS SpendRank
FROM sales_data
GROUP BY CustomerID
ORDER BY TotalSpend DESC
LIMIT 5;

