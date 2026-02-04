CREATE DATABASE eda_project;
USE eda_project;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    join_date DATE
);
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    city VARCHAR(100),
    segment VARCHAR(50)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    sale_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
/*Insert data for users */
INSERT INTO users (name, join_date) VALUES
('Amit', '2025-01-10'),
('Ravi', '2025-02-15'),
('Neha', '2025-03-12'),
('Sana', '2025-04-05'),
('Karan', '2025-05-20');
/* Insert data for Customers */
INSERT INTO customers (name, city, segment) VALUES
('Rahul', 'Delhi', 'Premium'),
('Anjali', 'Mumbai', 'Regular'),
('Suresh', 'Pune', 'Premium'),
('Meena', 'Chennai', 'Regular'),
('Rohit', 'Delhi', 'Premium');
/* Insert data for Products */
INSERT INTO products (product_name, price) VALUES
('Laptop', 50000),
('Mobile', 20000),
('Tablet', 15000),
('Headphones', 3000),
('Smartwatch', 8000);
/* Insert data for sales */
INSERT INTO sales (customer_id, product_id, amount, payment_method, sale_date) VALUES
(1, 1, 50000, 'Credit Card', '2025-01-10'),
(2, 2, 20000, 'UPI', '2025-02-15'),
(3, 3, 15000, 'Debit Card', '2025-03-18'),
(4, 4, 3000, 'Cash', '2025-04-20'),
(5, 5, 8000, 'UPI', '2025-05-10'),
(1, 2, 20000, 'Credit Card', '2025-06-05'),
(3, 1, 50000, 'UPI', '2025-07-12');
-- Top 5 products by revenue in the last 6 months
SELECT 
    p.product_name,
    SUM(s.amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;
/* Monthly User Acquisition Trend (Last 1 Year) */
SELECT 
    DATE_FORMAT(u.join_date, '%Y-%m') AS month,
    COUNT(u.user_id) AS new_users
FROM users u
WHERE u.join_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY month
ORDER BY month;
/*City with Highest Total Sales*/
SELECT 
    c.city,
    SUM(s.amount) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.id
WHERE s.sale_date >= '2024-04-01'
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 1;
/*Average Order Value for Premium Customers */
Select
AVG(s.amount) AS avg_order_value
FROM sales s
JOIN customers c ON s.customer_id = c.id
WHERE c.segment = 'Premium';
 

/*Top 3 Payment Methods (Last Quarter)*/
SELECT 
    payment_method,
    COUNT(*) AS total_transactions
FROM sales
WHERE sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY payment_method
ORDER BY total_transactions DESC
LIMIT 3;
/* check our data */
SELECT * FROM users;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM  sales;
