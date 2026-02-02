E-Commerce Data Analysis using SQL
📌 Project Overview

This project demonstrates end-to-end data analysis using SQL on an e-commerce database.
The goal is to extract business insights related to sales performance, customer behavior, product trends, inventory health, and reviews.

It is designed as a portfolio project for data analysis roles.

🗄️ Database Schema

The project uses the following tables:

Customers – customer details and tiers

Orders – order transactions and status

Order_Items – products inside each order

Products – product details, pricing, and stock

Categories – product categories with hierarchy

Suppliers – supplier information

Reviews – product ratings and feedback

Wishlist – customer wishlisted products

🔍 Key Analyses Performed
📊 Sales & Revenue Analysis

Monthly sales, revenue, and average order value

Delivered vs cancelled order impact

Month-over-month product sales comparison

👥 Customer Analytics

Customer Lifetime Value (CLV)

RFM-based customer segmentation

Active, at-risk, dormant, and lost customers

📦 Product Performance

Top-selling products and revenue leaders

Profit margin calculation

Hidden gems (low sales, high ratings)

Problem products (high sales, low ratings)

🏷️ Category Insights

Parent-child category hierarchy using recursive CTEs

Category-level revenue contribution

📉 Inventory Management

Stock status and reorder alerts

Days of stock remaining based on recent sales

🤝 Market Basket Analysis

Frequently bought-together products

Recommendation insights: “Customers who bought this also bought…”

🛠️ SQL Concepts Used

Common Table Expressions (CTEs)

Recursive CTEs

Window Functions (NTILE, SUM() OVER)

Joins (INNER, LEFT)

Aggregations & CASE statements

Date functions and cohort-style analysis

🎯 Project Outcome

This project shows how SQL can be used to:

Support business decisions

Improve inventory planning

Identify customer behavior patterns

Optimize product and marketing strategies
