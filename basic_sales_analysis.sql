-- Aggregate Metrics
SELECT 
    SUM(TransactionAmount) AS TotalSales,
    AVG(TransactionAmount) AS AvgSalesPerTransaction,
    SUM(Quantity) AS TotalQuantitySold,
    SUM(TransactionAmount * DiscountPercent / 100) AS TotalDiscountsGiven,
    SUM(TransactionAmount – ((TransactionAmount * DiscountPercent )/ 100)) AS TotalRevenueAfterDiscount
FROM sales_data;

-- Sales by City
SELECT 
    City, 
    SUM(TransactionAmount) AS SalesByCity
FROM sales_data
GROUP BY City;

-- Sales by Store Type
SELECT 
    StoreType, 
    SUM(TransactionAmount) AS SalesByStoreType
FROM sales_data
GROUP BY StoreType;

-- Sales by Product
SELECT 
    ProductName, 
    SUM(TransactionAmount) AS SalesByProduct
FROM sales_data
GROUP BY ProductName;

-- Sales by Payment Method
SELECT 
    PaymentMethod, 
    SUM(TransactionAmount) AS SalesByPaymentMethod
FROM sales_data
GROUP BY PaymentMethod;

-- Sales by Region
SELECT 
    Region, 
    SUM(TransactionAmount) AS SalesByRegion
FROM sales_data
GROUP BY Region;

-- Sales by Customer Age Group
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 20 AND 30 THEN '20-30'
        WHEN CustomerAge BETWEEN 31 AND 40 THEN '31-40'
        WHEN CustomerAge BETWEEN 41 AND 50 THEN '41-50'
        WHEN CustomerAge BETWEEN 51 AND 60 THEN '51-60'
        ELSE '60+'
    END AS AgeGroup,
    SUM(TransactionAmount) AS SalesByAgeGroup
FROM sales_data
GROUP BY AgeGroup;

-- Sales by Customer Gender
SELECT 
    CustomerGender, 
    SUM(TransactionAmount) AS SalesByGender
FROM sales_data
GROUP BY CustomerGender;

-- Promotional vs Non-Promotional Sales
SELECT 
    IsPromotional, 
    SUM(TransactionAmount) AS SalesByPromotion
FROM sales_data
GROUP BY IsPromotional;

-- Returned Items
SELECT 
    COUNT(*) AS ReturnedItemsCount,
    SUM(TransactionAmount) AS ReturnedItemsValue
FROM sales_data
WHERE Returned = 'Yes';

-- Average Delivery Time
SELECT 
    AVG(DeliveryTimeDays) AS AvgDeliveryTime
FROM sales_data;
