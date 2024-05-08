# SQL Swimwear Project

## Overview

A SQL project in which data relevant to sales in swimwear for an anonymous company is considered and selected from multiple datasets, SQL is used for aggregation and to do calculations such as conversion rate. The goal of the project was to study volatily in the swimwear category.
This project involves the creation and analysis of temporary tables using SQL queries on a database containing session, customer, order, and article event data. Through SQL I generate insights into customer behavior, sales performance, conversion rates, and other relevant metrics.

## Temporary Tables

1. **customer2**: Contains aggregated customer data joined from the session and customer tables.
   
2. **customer_orders**: Aggregates order data by session, including sales amount, number of items sold, channel, and delivery information.

3. **ProductViews**: (Not required for the project, included for reference)

4. **ProductSales**: Aggregates data on product sales by session.

5. **salesandviews**: Aggregates product views and sales data by session, distinguishing between article event types.

6. **conversionrate**: Calculates the conversion rate for each session based on product views and sales.

7. **PercReturned**: Calculates the percentage of returned items compared to delivered items for each session.

8. **weekday1**: Extracts the day of the week from session dates.

9. **finaltable**: Integrates data from multiple tables to provide a comprehensive view of customer behavior, including demographic information, order details, conversion rates, and returned item percentages.

## SQL Queries and Analysis

The SQL queries provided in this README are designed to create and populate the temporary tables necessary for analysis. The finaltable consolidates relevant data for further analysis.

## Results

After executing the SQL queries, the following insights were obtained:

- Total number of sessions in the final table: 126,375
- Total number of product views: 561,349
- Total number of sales: 35,251
- Overall conversion rate: 6.28%

## Note

Ensure that the database schema matches the table and column names referenced in the SQL queries for accurate execution.



<img width="998" alt="Screenshot 2023-06-26 at 21 08 17" src="https://github.com/alelledo/sql/assets/104741193/0c3e956c-69cc-4f63-b5dd-1e407765a71d">
