# Mexico-Toys-Sales

This project aims to provide an analysis of toy sales data in Mexico using SQL. This data set is obtained from Maven Analytics. The dataset used for the analysis consists of sales data from various toy stores in Mexico, including information such as store location, product details, sales date, and sales quantity.

## Dataset

The dataset used for this analysis includes the following tables and columns:

**inventory:**

| Column                  | Description                                                 | Data Type  |
| :---------------------- | :-----------------------------------------------------------| :--------- |
| Store_ID                | ID of stores                                                | INT        |
| Product_ID              | ID of Products                                              | INT        |
| Stock_On_Hand           | Stock quantity of the product in the store or inventory     | INT        |


**products:**

| Column                  | Description                     | Data Type    |
| :---------------------- | :------------------------------ | :----------- |
| Product_ID              | Product ID                      | INT          |
| Product_name            | Product Name                    | VARCHAR(50)  |
| Product_Category        | Product category                | VARCHAR(50)  |
| Product_Cost            | Product cost in USD             | FLOAT        |
| Product_Price           | Product retail price in USD     | FLOAT        |


**sales:**

| Column          | Description                            | Data Type    |
| :-------------- | :------------------------------------- | :----------- |
| Sales_ID        | Sales ID                               | INT          |
| Date02          | Sales date in the format yyyy-mm-dd    | DATE         |
| Store_ID        | Store ID                               | INT          |
| Product_ID      | Product ID                             | INT          |
| Units           | Number of units                        | INT          |


**stores:**

| Column              | Description                                       | Data Type    |
| :------------------ | :------------------------------------------------ | :----------- |
| Store_ID            | Store ID                                          | INT          |
| Store_Name          | Store name                                        | VARCHAR(50)  |
| Store_City          | City in Mexico where the store is located         | VARCHAR(50)  |
| Store_Location      | Location in the city where the store is located   | VARCHAR(50)  |
| Store_Open_date     | Date when the store was opened                    | DATE         |


**calendar:**

| Column        | Description     | Data Type    |
| :------------ | :-------------- | :----------- |
| Date01        | Calendar date   | DATE         |


## Analysis questions

1. Which are the product categories present in the dataset?
2. Which product categories drive the biggest sales?
3. How much revenue did each product category make per year?
4. Determine the overall sales and profit by month.
5. Determine the number of all the units of products sold by quarter.
6. Determine the top 3 products by units sold in each quarter.
7. Determine the number of units sold and profits made in each quarter.
8. Sales of top 5 products.
9. Which product categories drive the biggest sales across store location?
10. Whihch store locations has the highest sales and profit?
11. Determine the top 5 stores by sales.
12. Determine the top 5 stores by profit.
13. Determine the top 5 cities by sales.
14. Determine the top 5 cities by profit.
15. Determine the stock on hand by store city.
16. Products, stocks and store name.
17. How many stores are there in each city?
18. All time total sales, units sold, cost occurred and profit of toy stores in Mexico

