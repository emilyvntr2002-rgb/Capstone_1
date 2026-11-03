-- Capstone 1: Business Analysis with SQL and Excel
-- Territory: South Carolina
-- Region: South

USE sample_sales;
-- Question 1: Total online revenue for South Carolina

SELECT
    SUM(SalesTotal) AS Total_Online_Revenue,
    MIN(Date) AS First_Transaction,
    MAX(Date) AS Last_Transaction
FROM Online_Sales
WHERE ShiptoState = 'South Carolina';

SELECT
    SUM(SS.Sale_Amount) AS Total_Store_Revenue,
    MIN(SS.Transaction_Date) AS First_Transaction,
    MAX(SS.Transaction_Date) AS Last_Transaction
FROM Store_Sales SS
JOIN Store_Locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'South Carolina';

-- Question 2: Online revenue by year and month

SELECT
    YEAR(Date) AS Sales_Year,
    MONTH(Date) AS Sales_Month,
    SUM(SalesTotal) AS Monthly_Revenue
FROM Online_Sales
WHERE ShiptoState = 'South Carolina'
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    Sales_Year,
    Sales_Month;
    
-- Question 2: In-store revenue by year and month

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    MONTH(SS.Transaction_Date) AS Sales_Month,
    SUM(SS.Sale_Amount) AS Monthly_Revenue
FROM Store_Sales SS
JOIN Store_Locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'South Carolina'
GROUP BY
    YEAR(SS.Transaction_Date),
    MONTH(SS.Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Month;   
    
    -- Question 3: Online revenue for the South region

SELECT
    M.Region,
    SUM(OS.SalesTotal) AS Total_Online_Revenue
FROM Online_Sales OS
JOIN Management M
    ON OS.ShiptoState = M.State
WHERE M.Region = 'South'
GROUP BY M.Region;

-- Question 3: In-store revenue for the South region

SELECT
    M.Region,
    SUM(SS.Sale_Amount) AS Total_Store_Revenue
FROM Store_Sales SS
JOIN Store_Locations SL
    ON SS.Store_ID = SL.StoreId
JOIN Management M
    ON SL.State = M.State
WHERE M.Region = 'South'
GROUP BY M.Region;

-- Question 4: Online transactions by month and category

SELECT
    YEAR(OS.Date) AS Sales_Year,
    MONTH(OS.Date) AS Sales_Month,
    IC.Category,
    COUNT(*) AS Transaction_Count,
    AVG(OS.SalesTotal) AS Average_Transaction_Amount
FROM Online_Sales OS
JOIN Products P
    ON OS.ProdNum = P.ProdNum
JOIN Inventory_Categories IC
    ON P.CategoryID = IC.CategoryID
WHERE OS.ShiptoState = 'South Carolina'
GROUP BY
    YEAR(OS.Date),
    MONTH(OS.Date),
    IC.Category
ORDER BY
    Sales_Year,
    Sales_Month,
    IC.Category;
    
-- Question 4: In-store transactions by month and category

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    MONTH(SS.Transaction_Date) AS Sales_Month,
    IC.Category,
    COUNT(*) AS Transaction_Count,
    AVG(SS.Sale_Amount) AS Average_Transaction_Amount
FROM Store_Sales SS
JOIN Products P
    ON SS.Prod_Num = P.ProdNum
JOIN Inventory_Categories IC
    ON P.CategoryID = IC.CategoryID
JOIN Store_Locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'South Carolina'
GROUP BY
    YEAR(SS.Transaction_Date),
    MONTH(SS.Transaction_Date),
    IC.Category
ORDER BY
    Sales_Year,
    Sales_Month,
    IC.Category;
    
-- Question 5: Rank online states by revenue

SELECT
    ShiptoState,
    SUM(SalesTotal) AS Total_Revenue
FROM Online_Sales
GROUP BY ShiptoState
ORDER BY Total_Revenue DESC;

-- Question 6: Business Recommendation

-- Based on the sales analysis, I recommend that EmporiUm
-- focus on increasing both online and in-store sales in
-- South Carolina, with additional attention to online revenue.
-- The company should promote Technology & Accessories and
-- create marketing campaigns during slower sales months.
-- These strategies could help improve South Carolina's
-- sales performance and contribution to the South region.