-- 1. Which are the Product Categories present in the dataset?

SELECT DISTINCT(Product_Category), COUNT(Product_Category) AS Count_Product_Category
FROM products
GROUP BY Product_Category
ORDER BY Count_Product_Category DESC;


-- 2. Which product categories drive the biggest sales?

SELECT p.Product_Category, ROUND(SUM(p.Product_Price * s.units), 2) AS Total
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
GROUP BY p.Product_Category
ORDER BY Total DESC;


-- 3. How much revenue did each product category make per year?

SELECT p.Product_Category, ROUND(SUM(p.Product_Price * s.units), 2) AS Total, year(s.Date02) AS Yr
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
GROUP BY yr, p.Product_Category
ORDER BY p.Product_Category , Total DESC;


-- 4. Determine the overall Sales and profit by month

WITH cte AS (
SELECT monthname(s.Date02) AS Mnth, month(s.Date02) AS mnth_num, 
	ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales, 
	ROUND(SUM(p.Product_cost * s.units), 2) AS Total_cost
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
GROUP BY Mnth)

SELECT Mnth, Total_sales, ROUND(Total_sales - Total_cost) AS Profit
FROM cte
ORDER BY mnth_num;


-- 5. Number of  all the units of products sold by quarter

SELECT p.Product_ID, p.Product_Name, SUM(s.Units) AS Units_sold, quarter(s.date02) AS qtr
FROM sales s
JOIN products p
	ON p.Product_ID = s.Product_ID
GROUP BY qtr, p.Product_ID
ORDER BY p.Product_ID, qtr;


-- 6. Top 3 Products by units sold in each quarter

WITH cte AS (
SELECT p.Product_ID AS Product_ID, p.Product_Name AS Product_Name, SUM(s.Units) AS Units_sold, 
	quarter(s.date02) AS qtr,
	RANK() OVER(partition by quarter(s.date02) ORDER BY SUM(s.Units) DESC) rank_by_qtr
FROM sales s
JOIN products p
	ON p.Product_ID = s.Product_ID
GROUP BY qtr, p.Product_ID
)

SELECT Product_ID, Product_Name, Units_sold, qtr, rank_by_qtr
FROM cte
WHERE rank_by_qtr = 1 OR rank_by_qtr = 2 OR rank_by_qtr = 3;


-- 7. Number of units sold and profit made in each quarter

WITH cte AS (
SELECT year(date02) AS yr, quarter(date02) AS qtr, SUM(Units) AS sold, 
	ROUND(SUM(p.Product_Price * s.units), 2) AS Total_price, 
    ROUND(SUM(p.Product_cost * s.units), 2) AS Total_cost
FROM sales s
JOIN products p
	ON p.Product_ID = s.Product_ID
GROUP BY yr, qtr
)

SELECT yr, qtr, sold, Total_price, Total_cost, ROUND((Total_price - Total_cost), 2) AS Profit
FROM cte;


-- 8. Sales of top 5 products

SELECT p.Product_Name, ROUND(SUM(p.Product_Price * s.units), 2) AS Total
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
JOIN stores str
	ON s.Store_ID = str.Store_ID
GROUP BY p.Product_name
ORDER BY Total DESC
LIMIT 5;


-- 9. Which product categories drive the biggest sales across store locations?

SELECT p.Product_Category, str.Store_Location, ROUND(SUM(p.Product_Price * s.units), 2) AS Total
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
JOIN stores str
	ON s.Store_ID = str.Store_ID
GROUP BY p.Product_Category, str.Store_Location
ORDER BY Total DESC;


-- 10. Which store locations has highest sales and profit?

WITH cte AS (
SELECT str.Store_Location, SUM(s.Units) AS units_sold, 
	ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales, 
	ROUND(SUM(p.Product_Cost * s.units), 2) AS total_cost
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
JOIN stores str
	ON s.Store_ID = str.Store_ID
GROUP BY str.Store_Location)

SELECT Store_Location, units_sold, Total_sales, ROUND(Total_sales - total_cost) AS Profit
FROM cte
ORDER BY Profit DESC;


-- 11. Top 5 stores by sales

SELECT str.Store_ID, str.Store_Name, ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales
FROM sales s
JOIN stores str
	ON s.Store_ID = str.Store_ID
JOIN products p
	ON s.Product_ID = p.Product_ID
GROUP BY str.Store_ID
ORDER BY Total_sales DESC
LIMIT 5;


-- 12. Top 5 stores by profit

WITH cte AS (
SELECT str.Store_ID, str.Store_Name, ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales, 
	ROUND(SUM(p.Product_Cost * s.units), 2) AS total_cost
FROM sales s
JOIN stores str
	ON s.Store_ID = str.Store_ID
JOIN products p
	ON s.Product_ID = p.Product_ID
GROUP BY str.Store_ID
)

SELECT Store_ID, Store_Name, ROUND(Total_sales - total_cost) AS Profit
FROM cte
ORDER BY Profit DESC
LIMIT 5;


-- 13. Top 5 cities by sales

SELECT str.Store_City, ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales
FROM sales s
JOIN stores str
	ON s.Store_ID = str.Store_ID
JOIN products p
	ON s.Product_ID = p.Product_ID
GROUP BY str.Store_City
ORDER BY Total_sales DESC
LIMIT 5;


-- 14. Top 5 cities by profit

WITH cte AS (
SELECT str.Store_City, ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales, 
	ROUND(SUM(p.Product_Cost * s.units), 2) AS total_cost
FROM sales s
JOIN stores str
	ON s.Store_ID = str.Store_ID
JOIN products p
	ON s.Product_ID = p.Product_ID
GROUP BY str.Store_City
)

SELECT Store_City, ROUND(Total_sales - total_cost) AS Profit
FROM cte
ORDER BY Profit DESC
LIMIT 5;


-- 15. Determine the Stock on Hand by store city

SELECT s.Store_ID, s.Store_City, SUM(i.Stock_On_Hand) AS Stock_in_City
FROM inventory i
JOIN stores s
	ON i.Store_ID = s.Store_ID
GROUP BY s.Store_City
ORDER BY s.Store_City;


-- 16. Products, stocks and store name

SELECT s.Store_ID, p.Product_ID, i.Stock_On_Hand AS Stock_in_Hand, s.Store_Name, 
	s.Store_Location, s.Store_City
FROM stores s
JOIN inventory i
	ON s.Store_ID = i.Store_ID
JOIN products p
	ON i.Product_ID = p.Product_ID;


-- 17. How many stores are there in each city?

SELECT Store_City, COUNT(Store_City) AS Num_of_stores
FROM stores
GROUP BY Store_City
ORDER BY 2 DESC, Store_City;


-- 18. All time total sales, units sold, cost occurred and profit of Mexico toy stores

SELECT ROUND(SUM(p.Product_Price * s.units), 2) AS Total_sales, SUM(s.units) AS units_sold, 
	ROUND(SUM(p.Product_Cost * s.units), 2) AS Product_cost,
	ROUND(ROUND(SUM(p.Product_Price * s.units), 2) - ROUND(SUM(p.Product_Cost * s.units), 2), 2 ) AS Profit
FROM products p
JOIN sales s
	ON p.Product_ID = s.Product_ID
JOIN stores str
	ON s.Store_ID = str.Store_ID;