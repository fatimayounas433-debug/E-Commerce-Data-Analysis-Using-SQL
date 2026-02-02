CREATE DATABASE ECommerceDB;
select *
from Customers;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE DEFAULT (CURRENT_DATE),
    customer_tier ENUM('Bronze', 'Silver', 'Gold', 'Platinum') DEFAULT 'Bronze'
);



-- Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    description TEXT,
    FOREIGN KEY (parent_category_id) REFERENCES Categories(category_id)
);
----- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    cost_price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    supplier_id INT,
    created_date DATE DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
select*
from order_items


-- Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    country VARCHAR(50),
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5)
);



CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_address VARCHAR(255),
    shipping_city VARCHAR(50),
    shipping_country VARCHAR(50),
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'COD', 'Bank Transfer'),
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    discount_amount DECIMAL(10,2) DEFAULT 0,
    shipping_cost DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);



------  Order Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
select *
from Reviews;
-- Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_verified_purchase BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Wishlist Table
CREATE TABLE Wishlist (
    wishlist_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    added_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    UNIQUE(customer_id, product_id)
);

--- Insert Customers

INSERT INTO Customers (first_name, last_name, email, phone, city, country, customer_tier) VALUES
('John', 'Smith', 'john.smith@email.com', '1234567890', 'New York', 'USA', 'Gold'),
('Emma', 'Johnson', 'emma.j@email.com', '2345678901', 'Los Angeles', 'USA', 'Silver'),
('Michael', 'Williams', 'michael.w@email.com', '3456789012', 'Chicago', 'USA', 'Platinum'),
('Sarah', 'Brown', 'sarah.b@email.com', '4567890123', 'Houston', 'USA', 'Bronze'),
('David', 'Jones', 'david.j@email.com', '5678901234', 'London', 'UK', 'Gold'),
('Lisa', 'Garcia', 'lisa.g@email.com', '6789012345', 'Toronto', 'Canada', 'Silver'),
('James', 'Miller', 'james.m@email.com', '7890123456', 'Sydney', 'Australia', 'Bronze'),
('Jennifer', 'Davis', 'jennifer.d@email.com', '8901234567', 'Mumbai', 'India', 'Gold'),
('Robert', 'Rodriguez', 'robert.r@email.com', '9012345678', 'Berlin', 'Germany', 'Silver'),
('Emily', 'Martinez', 'emily.m@email.com', '0123456789', 'Paris', 'France', 'Platinum');

-- Insert Categories
INSERT INTO Categories (category_name, parent_category_id, description) VALUES
('Electronics', NULL, 'Electronic devices and accessories'),
('Clothing', NULL, 'Fashion and apparel'),
('Home & Kitchen', NULL, 'Home appliances and kitchenware'),
('Smartphones', 1, 'Mobile phones and accessories'),
('Laptops', 1, 'Notebook computers'),
('Men''s Clothing', 2, 'Clothing for men'),
('Women''s Clothing', 2, 'Clothing for women'),
('Kitchen Appliances', 3, 'Cooking and kitchen devices');

-- Insert Suppliers
INSERT INTO Suppliers (supplier_name, contact_person, email, phone, city, country, rating) VALUES
('TechSupply Co', 'Tom Wilson', 'tom@techsupply.com', '1111111111', 'Shenzhen', 'China', 4.5),
('Fashion World', 'Anna Lee', 'anna@fashionworld.com', '2222222222', 'Milan', 'Italy', 4.2),
('Home Essentials', 'Mark Brown', 'mark@homeessentials.com', '3333333333', 'Chicago', 'USA', 4.8);

-- Insert Products
INSERT INTO Products (product_name, category_id, price, cost_price, stock_quantity, supplier_id) VALUES
('iPhone 15 Pro', 4, 1199.99, 800.00, 50, 1),
('Samsung Galaxy S24', 4, 999.99, 650.00, 75, 1),
('MacBook Pro 16"', 5, 2499.99, 1800.00, 30, 1),
('Dell XPS 15', 5, 1799.99, 1200.00, 45, 1),
('Men''s Cotton T-Shirt', 6, 29.99, 12.00, 200, 2),
('Women''s Summer Dress', 7, 59.99, 25.00, 150, 2),
('Blender Pro 3000', 8, 149.99, 75.00, 80, 3),
('Coffee Maker Deluxe', 8, 199.99, 95.00, 60, 3),
('Wireless Earbuds', 1, 149.99, 70.00, 100, 1),
('Smart Watch Series 5', 1, 399.99, 200.00, 85, 1);

-- Insert Orders
INSERT INTO Orders (customer_id, order_date, shipping_city, shipping_country, order_status, payment_method, payment_status, discount_amount, shipping_cost, total_amount) VALUES
(1, '2024-01-15 10:30:00', 'New York', 'USA', 'Delivered', 'Credit Card', 'Completed', 50.00, 15.00, 1164.99),
(2, '2024-01-20 14:45:00', 'Los Angeles', 'USA', 'Delivered', 'PayPal', 'Completed', 0.00, 10.00, 1009.99),
(3, '2024-02-05 09:15:00', 'Chicago', 'USA', 'Shipped', 'Credit Card', 'Completed', 100.00, 20.00, 2419.99),
(1, '2024-02-10 16:20:00', 'New York', 'USA', 'Processing', 'Debit Card', 'Completed', 25.00, 15.00, 439.98),
(4, '2024-02-15 11:00:00', 'Houston', 'USA', 'Pending', 'COD', 'Pending', 0.00, 12.00, 211.98),
(5, '2024-02-20 13:30:00', 'London', 'UK', 'Delivered', 'Bank Transfer', 'Completed', 75.00, 25.00, 1949.99),
(6, '2024-03-01 08:45:00', 'Toronto', 'Canada', 'Cancelled', 'Credit Card', 'Refunded', 0.00, 18.00, 629.97),
(7, '2024-03-05 15:10:00', 'Sydney', 'Australia', 'Delivered', 'PayPal', 'Completed', 30.00, 30.00, 369.98),
(8, '2024-03-10 10:00:00', 'Mumbai', 'India', 'Shipped', 'Credit Card', 'Completed', 0.00, 22.00, 1371.98),
(9, '2024-03-15 12:25:00', 'Berlin', 'Germany', 'Pending', 'Bank Transfer', 'Pending', 50.00, 20.00, 569.98);

-- Insert Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1, 1, 1, 1199.99, 0),
(2, 2, 1, 999.99, 0),
(3, 3, 1, 2499.99, 0),
(4, 10, 1, 399.99, 5),
(4, 5, 2, 29.99, 0),
(5, 7, 1, 149.99, 0),
(5, 5, 2, 29.99, 0),
(6, 4, 1, 1799.99, 0),
(6, 9, 1, 149.99, 10),
(7, 6, 3, 59.99, 0),
(7, 8, 2, 199.99, 5),
(8, 10, 1, 399.99, 0),
(9, 1, 1, 1199.99, 0),
(9, 9, 1, 149.99, 0),
(10, 7, 2, 149.99, 0),
(10, 8, 1, 199.99, 10);

-- Insert Reviews
INSERT INTO Reviews (product_id, customer_id, rating, review_text, is_verified_purchase) VALUES
(1, 1, 5, 'Excellent phone! Best I have ever used.', TRUE),
(1, 3, 4, 'Great phone but expensive.', TRUE),
(2, 2, 4, 'Good value for money.', TRUE),
(3, 3, 5, 'Perfect for professional work.', TRUE),
(4, 5, 4, 'Great laptop, fast delivery.', TRUE),
(7, 4, 3, 'Decent blender, could be better.', TRUE),
(10, 7, 5, 'Amazing smartwatch features!', TRUE);

select*
from Wishlist;

- Insert Wishlist Data
INSERT INTO Wishlist (customer_id, product_id, added_date) VALUES
(1, 3, '2024-01-10 09:00:00'),    -- John wants MacBook Pro
(1, 10, '2024-01-12 14:30:00'),   -- John wants Smart Watch
(2, 1, '2024-01-18 11:15:00'),    -- Emma wants iPhone 15 Pro
(2, 6, '2024-01-22 16:45:00'),    -- Emma wants Summer Dress
(3, 9, '2024-02-01 10:00:00'),    -- Michael wants Wireless Earbuds
(4, 2, '2024-02-10 13:20:00'),    -- Sarah wants Samsung Galaxy
(4, 8, '2024-02-12 15:00:00'),    -- Sarah wants Coffee Maker
(5, 3, '2024-02-18 09:30:00'),    -- David wants MacBook Pro
(6, 1, '2024-02-25 12:00:00'),    -- Lisa wants iPhone 15 Pro
(6, 10, '2024-02-28 17:45:00'),   -- Lisa wants Smart Watch
(7, 4, '2024-03-02 08:15:00'),    -- James wants Dell XPS
(8, 6, '2024-03-08 14:00:00'),    -- Jennifer wants Summer Dress
(8, 7, '2024-03-09 11:30:00'),    -- Jennifer wants Blender
(9, 5, '2024-03-12 10:45:00'),    -- Robert wants T-Shirt
(10, 2, '2024-03-14 16:00:00');   -- Emily wants Samsung Galaxy



select*
from Orders;

----- Find total sales, order count, and average order value per month
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    SUM(CASE WHEN order_status = 'Delivered' THEN total_amount ELSE 0 END) AS delivered_revenue,
    COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) AS cancelled_orders
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

select*
from Products p;
select *
from orders o;
select*
from customers c;

select*
from categories ca;

select*
from order_items oi;

select*
from customers c;

select*
from reviews r;

select*
from wishlist w;

select *
from suppliers s;

select 
p.product_id,
p.product_name,
c.category_name,
sum(oi.quantity) as total_units_sold,
sum(oi.quantity * oi.unit_price * (1- oi.discount_percent/100)) as total_revenue,
p.stock_quantity,
case 
        when p.stock_quantity = 0 then 'out of stock'
        when p.stock_quantity <= p.reorder_level then 'low stock'
        else  'in stock'
end as stock_status,
        Round ((p.price -p.cost_price) / p.price * 100, 2)  as profit_margin_percent 
        from products p
        join categories c ON p.category_id = c.category_id
        JOIN Order_Items oi ON p.product_id = oi.product_id
	   JOIN Orders o ON oi.order_id = o.order_id 
       WHERE o.order_status != 'Cancelled'
       GROUP BY p.product_id, p.product_name, c.category_name, p.stock_quantity, p.reorder_level, p.price, p.cost_price
       ORDER BY total_revenue DESC
	   LIMIT 10;

----- Calculate customer lifetime value with RFM segmentation
 with CustomerMetrics as (
 select 
          c. customer_id,
          concat(c.first_name, '  ' , c.last_name) as customer_name,
          c.customer_tier,
          c.registration_date,
		 COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS lifetime_value,
        AVG(o.total_amount) AS avg_order_value,
        MAX(o.order_date) AS last_order_date,
        MIN(o.order_date) AS first_order_date,
         DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order
         FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id 
        AND o.order_status != 'Cancelled'
    GROUP BY c.customer_id, c.first_name, c.last_name, c.customer_tier, c.registration_date
)
 SELECT 
    customer_id,
    customer_name,
    customer_tier,
    total_orders,
    ROUND(lifetime_value, 2) AS lifetime_value,
    ROUND(avg_order_value, 2) AS avg_order_value,
    days_since_last_order,
    CASE 
        WHEN days_since_last_order <= 30 AND total_orders >= 3 THEN 'VIP Active'
        WHEN days_since_last_order <= 30 THEN 'Active'
        WHEN days_since_last_order <= 90 THEN 'At Risk'
        WHEN days_since_last_order <= 180 THEN 'Dormant'
        ELSE 'Lost'
    END AS customer_segment,
    DATEDIFF(CURRENT_DATE, registration_date) AS customer_age_days
FROM CustomerMetrics
ORDER BY lifetime_value DESC;
        
        
        
        Compare current month vs previous month sales

SQL

WITH MonthlySales AS (
    SELECT 
        p.product_id,
        p.product_name,
        DATE_FORMAT(o.order_date, '%Y-%m') AS sale_month,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM Products p
    JOIN Order_Items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY p.product_id, p.product_name, DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
    curr.product_id,
    curr.product_name,
    curr.sale_month AS current_month,
    curr.units_sold AS current_units,
    curr.revenue AS current_revenue,
    prev.units_sold AS previous_units,
    prev.revenue AS previous_revenue,
    ROUND(((curr.revenue - COALESCE(prev.revenue, 0)) / NULLIF(prev.revenue, 0)) * 100, 2) AS revenue_growth_percent,
    CASE 
        WHEN curr.revenue > COALESCE(prev.revenue, 0) THEN '📈 Growing'
        WHEN curr.revenue < COALESCE(prev.revenue, 0) THEN '📉 Declining'
        ELSE '➡️ Stable'
    END AS trend
FROM MonthlySales curr
LEFT JOIN MonthlySales prev ON curr.product_id = prev.product_id 
    AND prev.sale_month = DATE_FORMAT(DATE_SUB(STR_TO_DATE(CONCAT(curr.sale_month, '-01'), '%Y-%m-%d'), INTERVAL 1 MONTH), '%Y-%m')
ORDER BY curr.sale_month DESC, curr.revenue DESC;

 show columns
 from products;
 

WITH avg_daily_sales AS (
    SELECT 
        oi.product_id, 
        ROUND(SUM(oi.quantity) / 30, 2) AS avg_daily_sales
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status != 'Cancelled'
      AND o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
    GROUP BY oi.product_id
)
SELECT
    p.product_id,
    p.product_name,
    ca.category_name,
    s.supplier_name, 
    s.email AS supplier_email,
    p.stock_quantity AS current_stock,
    p.reorder_level,
    p.stock_quantity - p.reorder_level AS stock_difference,
    COALESCE(a.avg_daily_sales, 0) AS avg_daily_sales,
    CASE 
        WHEN COALESCE(a.avg_daily_sales, 0) > 0 
        THEN ROUND(p.stock_quantity / a.avg_daily_sales, 0)
        ELSE 999
    END AS days_of_stock_remaining,
    CASE 
        WHEN COALESCE(a.avg_daily_sales, 0) = 0 THEN '🔴 NO SALES DATA'
        WHEN ROUND(p.stock_quantity / COALESCE(a.avg_daily_sales, 0), 0) <= 3 THEN '🟠 CRITICAL'
        WHEN ROUND(p.stock_quantity / COALESCE(a.avg_daily_sales, 0), 0) <= 7 THEN '🟡 LOW STOCK'
        ELSE '🟢 OK'
    END AS stock_status
FROM Products p 
JOIN Categories c ON p.category_id = c.category_id 
LEFT JOIN Suppliers s ON p.supplier_id = s.supplier_id 
LEFT JOIN avg_daily_sales a ON p.product_id = a.product_id
WHERE p.is_active = 1
ORDER BY stock_difference ASC;

--- find parent category revenue 

WITH RECURSIVE CategoryHierarchy AS (
    SELECT 
        category_id,
        category_name,
        parent_category_id,
        category_name AS full_path,
        0 AS level
    FROM Categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT 
        c.category_id,
        c.category_name,
        c.parent_category_id,
        CONCAT(ch.full_path, ' > ', c.category_name),
        ch.level + 1
    FROM Categories c
    JOIN CategoryHierarchy ch ON c.parent_category_id = ch.category_id
),
CategoryRevenue AS (
    SELECT 
        c.category_id,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS revenue,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(oi.quantity) AS units_sold
    FROM Categories c
    JOIN Products p ON c.category_id = p.category_id
    JOIN Order_Items oi ON p.product_id = oi.product_id
    JOIN Orders o ON oi.order_id = o.order_id
    WHERE o.order_status != 'Cancelled'
    GROUP BY c.category_id
)
SELECT 
    ch.category_id,
    CONCAT(REPEAT('  ', ch.level), ch.category_name) AS category_name,
    ch.full_path,
    ch.level,
    COALESCE(cr.revenue, 0) AS revenue,
    COALESCE(cr.order_count, 0) AS order_count,
    COALESCE(cr.units_sold, 0) AS units_sold,
    ROUND(COALESCE(cr.revenue, 0) * 100.0 / SUM(cr.revenue) OVER(), 2) AS revenue_percentage
FROM CategoryHierarchy ch
LEFT JOIN CategoryRevenue cr ON ch.category_id = cr.category_id
ORDER BY ch.full_path;
 
 
----  Find products that are frequently purchased together in the same order
-- Useful for "Customers who bought this also bought..." recommendations
 
 
 WITH OrderProducts AS (
    SELECT 
        o.order_id,
        oi.product_id,
        p.product_name
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE o.order_status != 'Cancelled'
)
SELECT 
    op1.product_name AS product_1,
    op2.product_name AS product_2,
    COUNT(*) AS times_bought_together
FROM OrderProducts op1
JOIN OrderProducts op2 
    ON op1.order_id = op2.order_id
    AND op1.product_id < op2.product_id
GROUP BY op1.product_name, op2.product_name
ORDER BY times_bought_together DESC;

 ---- Identify products with mismatch between sales and reviews
-- Find hidden gems (great reviews, low sales) and problem products (high sales, poor reviews)



WITH ProductSales AS (
    SELECT 
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(oi.quantity) AS total_units_sold,
        SUM(oi.quantity * oi.unit_price * (1 - oi.discount_percent/100)) AS total_revenue
    FROM Products p
    JOIN Categories c ON p.category_id = c.category_id
    LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
    LEFT JOIN Orders o ON oi.order_id = o.order_id AND o.order_status != 'Cancelled'
    GROUP BY p.product_id, p.product_name, c.category_name
),
ProductReviews AS (
    SELECT 
        product_id,
        COUNT(*) AS review_count,
        ROUND(AVG(rating), 2) AS avg_rating,
        SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END) AS positive_reviews,
        SUM(CASE WHEN rating <= 2 THEN 1 ELSE 0 END) AS negative_reviews
    FROM Reviews
    GROUP BY product_id
),
ProductRanks AS (
    SELECT 
        ps.*,
        COALESCE(pr.review_count, 0) AS review_count,
        COALESCE(pr.avg_rating, 0) AS avg_rating,
        COALESCE(pr.positive_reviews, 0) AS positive_reviews,
        COALESCE(pr.negative_reviews, 0) AS negative_reviews,
        NTILE(4) OVER (ORDER BY ps.total_revenue DESC) AS sales_quartile,
        NTILE(4) OVER (ORDER BY COALESCE(pr.avg_rating, 0) DESC) AS rating_quartile
    FROM ProductSales ps
    LEFT JOIN ProductReviews pr ON ps.product_id = pr.product_id
)
SELECT 
    product_id,
    product_name,
    category_name,
    COALESCE(total_units_sold, 0) AS units_sold,
    ROUND(COALESCE(total_revenue, 0), 2) AS revenue,
    review_count,
    avg_rating,
    CASE 
        WHEN sales_quartile = 1 AND rating_quartile >= 3 THEN '⚠️ HIGH SALES, LOW RATING - Quality Issue!'
        WHEN sales_quartile >= 3 AND rating_quartile = 1 THEN '💎 HIDDEN GEM - Marketing Opportunity!'
        WHEN sales_quartile = 1 AND rating_quartile = 1 THEN '⭐ TOP PERFORMER'
        WHEN sales_quartile = 4 AND rating_quartile = 4 THEN '🔴 NEEDS ATTENTION'
        WHEN review_count = 0 THEN '📝 NO REVIEWS YET'
        ELSE '✅ NORMAL'
    END AS product_status,
    sales_quartile,
    rating_quartile
FROM ProductRanks
ORDER BY 
    CASE 
        WHEN sales_quartile = 1 AND rating_quartile >= 3 THEN 1
        WHEN sales_quartile >= 3 AND rating_quartile = 1 THEN 2
        ELSE 3
    END,
    total_revenue DESC;
